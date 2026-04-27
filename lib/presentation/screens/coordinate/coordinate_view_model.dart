import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/coordinate_generation_job.dart';
import '../../../domain/models/coordinate_generation_request.dart';
import '../../../domain/models/coordinate_item.dart';
import '../../../domain/models/coordinate_polling_recovery_state.dart';
import '../../../domain/models/coordinate_source_image_input.dart';
import '../../../domain/repository/coordinate_repository.dart';
import '../../../presentation/providers/auth_session_provider.dart';
import 'coordinate_state.dart';

final coordinateViewModelProvider =
    AutoDisposeNotifierProvider<CoordinateViewModel, CoordinateState>(
      CoordinateViewModel.new,
    );

class CoordinateViewModel extends AutoDisposeNotifier<CoordinateState> {
  static const _pageSize = 20;
  static const _pollingInterval = Duration(milliseconds: 1200);
  static const _pollingTimeout = Duration(seconds: 90);
  static const _promptMaxLength = 400;

  Timer? _pollingTimer;

  @override
  CoordinateState build() {
    ref.onDispose(_cancelPolling);
    return CoordinateState.initial();
  }

  Future<void> loadInitial() async {
    final userId = _userIdOrNull();
    if (userId == null || userId.isEmpty) {
      state = state.copyWith(
        requiresAuth: true,
        isLoadingInitial: false,
        hasMore: false,
      );
      return;
    }

    state = state.copyWith(
      isLoadingInitial: true,
      isLoadingMore: false,
      errorCode: null,
      submitErrorCode: null,
      validationErrorCode: null,
      infoMessageCode: null,
      requiresAuth: false,
      hasMore: true,
    );

    await Future.wait([
      _loadBalance(userId),
      _loadHistory(userId, reset: true),
    ]);
    await _recoverInProgress(userId);
  }

  Future<void> refresh() async {
    final userId = _userIdOrNull();
    if (userId == null || userId.isEmpty) {
      state = state.copyWith(requiresAuth: true, errorCode: 'unauthorized');
      return;
    }
    state = state.copyWith(errorCode: null, submitErrorCode: null);
    await Future.wait([
      _loadBalance(userId),
      _loadHistory(userId, reset: true),
    ]);
    await _recoverInProgress(userId);
  }

  Future<void> loadMore() async {
    if (state.isLoadingInitial || state.isLoadingMore || !state.hasMore) {
      return;
    }
    final userId = _userIdOrNull();
    if (userId == null || userId.isEmpty) {
      return;
    }
    state = state.copyWith(isLoadingMore: true, errorCode: null);
    await _loadHistory(userId, reset: false);
  }

  void updatePrompt(String value) {
    state = state.copyWith(
      prompt: value,
      validationErrorCode: null,
      submitErrorCode: null,
    );
  }

  void updateSourceMode(CoordinateImageSourceMode mode) {
    if (state.sourceMode == mode) {
      return;
    }
    state = state.copyWith(
      sourceMode: mode,
      sourceInput: CoordinateSourceImageInput(mode: mode),
      validationErrorCode: null,
    );
  }

  void updateSourceImageType(CoordinateSourceImageType type) {
    state = state.copyWith(sourceImageType: type);
  }

  void updateBackgroundMode(CoordinateBackgroundMode mode) {
    state = state.copyWith(backgroundMode: mode);
  }

  void updateModelTier(CoordinateModelTier tier) {
    final nextEstimate = getPercoinCost(tier) * state.outputCount;
    state = state.copyWith(
      modelTier: tier,
      estimatedPercoinCost: nextEstimate,
      submitErrorCode: null,
    );
  }

  void updateOutputCount(int count) {
    if (count > state.maxOutputCount) {
      state = state.copyWith(validationErrorCode: 'upgrade_required');
      return;
    }
    final sanitized = count.clamp(1, state.maxOutputCount);
    state = state.copyWith(
      outputCount: sanitized,
      estimatedPercoinCost: getPercoinCost(state.modelTier) * sanitized,
      validationErrorCode: null,
    );
  }

  void setStockSelection({required String stockId, String? previewUrl}) {
    state = state.copyWith(
      sourceInput: CoordinateSourceImageInput(
        mode: CoordinateImageSourceMode.stock,
        stockImageId: stockId,
        stockPreviewUrl: previewUrl,
      ),
      sourceMode: CoordinateImageSourceMode.stock,
      validationErrorCode: null,
      submitErrorCode: null,
    );
  }

  void setMockUpload({
    required String fileName,
    required String mimeType,
    required int sizeBytes,
  }) {
    state = state.copyWith(
      sourceInput: CoordinateSourceImageInput(
        mode: CoordinateImageSourceMode.upload,
        uploadFileName: fileName,
        uploadMimeType: mimeType,
        uploadSizeBytes: sizeBytes,
      ),
      sourceMode: CoordinateImageSourceMode.upload,
      validationErrorCode: null,
      submitErrorCode: null,
    );
  }

  Future<void> submitGeneration() async {
    final userId = _userIdOrNull();
    if (userId == null || userId.isEmpty) {
      state = state.copyWith(
        requiresAuth: true,
        submitErrorCode: 'unauthorized',
      );
      return;
    }

    final validationCode = _validateBeforeSubmit();
    if (validationCode != null) {
      state = state.copyWith(validationErrorCode: validationCode);
      return;
    }

    if (state.estimatedPercoinCost > state.percoinBalance) {
      state = state.copyWith(
        submitErrorCode: 'insufficient_balance',
        infoMessageCode: 'open_buy_percoins',
      );
      return;
    }

    state = state.copyWith(
      isSubmitting: true,
      submitErrorCode: null,
      validationErrorCode: null,
    );

    final request = CoordinateGenerationRequest(
      requestId: DateTime.now().microsecondsSinceEpoch.toString(),
      userId: userId,
      sourceImageInput: state.sourceInput,
      prompt: state.prompt.trim(),
      backgroundMode: state.backgroundMode,
      sourceImageType: state.sourceImageType,
      modelTier: state.modelTier,
      outputCount: state.outputCount,
      submittedAt: DateTime.now(),
    );

    try {
      final jobs = await ref
          .read(coordinateRepositoryProvider)
          .submitGeneration(request: request);
      state = state.copyWith(
        isSubmitting: false,
        activeJobs: _mergeJobs(state.activeJobs, jobs),
        pollingRecovery: state.pollingRecovery.copyWith(
          activePollingStartedAt: DateTime.now(),
          recoveryMessageVisible: false,
          timedOutJobIds: const [],
        ),
      );
      _startPolling(userId);
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        submitErrorCode: 'generation_submit_failed',
      );
    }
  }

  Future<void> openPercoinPurchase() async {
    state = state.copyWith(infoMessageCode: 'buy_percoins_todo');
  }

  Future<void> _loadBalance(String userId) async {
    try {
      final balance = await ref
          .read(coordinateRepositoryProvider)
          .getPercoinBalance(userId: userId);
      state = state.copyWith(percoinBalance: balance);
    } catch (_) {
      state = state.copyWith(errorCode: 'coordinate_balance_failed');
    }
  }

  Future<void> _loadHistory(String userId, {required bool reset}) async {
    try {
      final offset = reset ? 0 : state.items.length;
      final items = await ref
          .read(coordinateRepositoryProvider)
          .listCoordinateItems(
            userId: userId,
            limit: _pageSize,
            offset: offset,
          );
      final merged = reset ? items : _mergeItems(state.items, items);
      state = state.copyWith(
        items: merged,
        isLoadingInitial: false,
        isLoadingMore: false,
        hasMore: items.length == _pageSize,
        errorCode: null,
      );
    } catch (_) {
      state = state.copyWith(
        isLoadingInitial: false,
        isLoadingMore: false,
        hasMore: false,
        errorCode: 'coordinate_fetch_failed',
      );
    }
  }

  Future<void> _recoverInProgress(String userId) async {
    try {
      final jobs = await ref
          .read(coordinateRepositoryProvider)
          .recoverInProgressJobs(userId: userId);
      if (jobs.isEmpty) {
        return;
      }
      state = state.copyWith(
        activeJobs: _mergeJobs(state.activeJobs, jobs),
        pollingRecovery: state.pollingRecovery.copyWith(
          activePollingStartedAt: DateTime.now(),
          recoveryMessageVisible: false,
        ),
      );
      _startPolling(userId);
    } catch (_) {
      state = state.copyWith(errorCode: 'coordinate_recovery_failed');
    }
  }

  void _startPolling(String userId) {
    _cancelPolling();
    _pollingTimer = Timer.periodic(_pollingInterval, (_) {
      unawaited(_pollJobs(userId));
    });
  }

  Future<void> _pollJobs(String userId) async {
    final activeIds = state.activeJobs
        .where((job) => !job.isTerminal)
        .map((job) => job.jobId)
        .toList();

    if (activeIds.isEmpty) {
      _cancelPolling();
      await _loadBalance(userId);
      await _loadHistory(userId, reset: true);
      return;
    }

    final startedAt = state.pollingRecovery.activePollingStartedAt;
    if (startedAt != null &&
        DateTime.now().difference(startedAt) >= _pollingTimeout) {
      _cancelPolling();
      state = state.copyWith(
        pollingRecovery: state.pollingRecovery.copyWith(
          recoveryMessageVisible: true,
          timedOutJobIds: activeIds,
        ),
      );
      return;
    }

    try {
      final jobs = await ref
          .read(coordinateRepositoryProvider)
          .pollGenerationJobs(userId: userId, jobIds: activeIds);
      state = state.copyWith(
        activeJobs: _mergeJobs(state.activeJobs, jobs),
        submitErrorCode:
            jobs.any((job) => job.errorCode == 'insufficient_balance')
            ? 'insufficient_balance'
            : state.submitErrorCode,
      );
      if (jobs.every((job) => job.isTerminal)) {
        _cancelPolling();
        await _loadBalance(userId);
        await _loadHistory(userId, reset: true);
      }
    } catch (_) {
      state = state.copyWith(errorCode: 'coordinate_polling_failed');
    }
  }

  String? _validateBeforeSubmit() {
    final trimmedPrompt = state.prompt.trim();
    if (trimmedPrompt.isEmpty) {
      return 'missing_prompt';
    }
    if (trimmedPrompt.length > _promptMaxLength) {
      return 'prompt_too_long';
    }
    if (!state.sourceInput.hasSelection) {
      return 'missing_source_image';
    }
    if (state.sourceInput.mode == CoordinateImageSourceMode.upload) {
      final mime = state.sourceInput.uploadMimeType?.toLowerCase() ?? '';
      final allowed =
          mime == 'image/jpeg' || mime == 'image/png' || mime == 'image/webp';
      if (!allowed) {
        return 'unsupported_upload_type';
      }
      final sizeBytes = state.sourceInput.uploadSizeBytes ?? 0;
      if (sizeBytes > 10 * 1024 * 1024) {
        return 'upload_too_large';
      }
    }
    return null;
  }

  String? _userIdOrNull() {
    return ref.read(authSessionProvider).valueOrNull?.userId?.trim();
  }

  List<CoordinateItem> _mergeItems(
    List<CoordinateItem> current,
    List<CoordinateItem> incoming,
  ) {
    final merged = <CoordinateItem>[...current];
    final ids = current.map((item) => item.id).toSet();
    for (final item in incoming) {
      if (ids.add(item.id)) {
        merged.add(item);
      }
    }
    merged.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return merged;
  }

  List<CoordinateGenerationJob> _mergeJobs(
    List<CoordinateGenerationJob> current,
    List<CoordinateGenerationJob> incoming,
  ) {
    final byId = {for (final job in current) job.jobId: job};
    for (final job in incoming) {
      byId[job.jobId] = job;
    }
    final merged = byId.values.toList()
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return merged;
  }

  void _cancelPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }
}

extension on CoordinatePollingRecoveryState {
  CoordinatePollingRecoveryState copyWith({
    DateTime? activePollingStartedAt,
    int? timeoutSeconds,
    List<String>? timedOutJobIds,
    bool? recoveryMessageVisible,
    bool? resumeOnReentry,
  }) {
    return CoordinatePollingRecoveryState(
      activePollingStartedAt:
          activePollingStartedAt ?? this.activePollingStartedAt,
      timeoutSeconds: timeoutSeconds ?? this.timeoutSeconds,
      timedOutJobIds: timedOutJobIds ?? this.timedOutJobIds,
      recoveryMessageVisible:
          recoveryMessageVisible ?? this.recoveryMessageVisible,
      resumeOnReentry: resumeOnReentry ?? this.resumeOnReentry,
    );
  }
}
