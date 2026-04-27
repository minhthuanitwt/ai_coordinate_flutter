import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/supabase_service.dart';
import '../failures/coordinate_repository_failure.dart';
import '../models/coordinate_generation_job.dart';
import '../models/coordinate_generation_request.dart';
import '../models/coordinate_item.dart';

abstract class CoordinateRepository {
  Future<int> getPercoinBalance({required String userId});

  Future<List<CoordinateGenerationJob>> submitGeneration({
    required CoordinateGenerationRequest request,
  });

  Future<List<CoordinateGenerationJob>> pollGenerationJobs({
    required String userId,
    required List<String> jobIds,
  });

  Future<List<CoordinateGenerationJob>> recoverInProgressJobs({
    required String userId,
  });

  Future<List<CoordinateItem>> listCoordinateItems({
    required String userId,
    int limit = 20,
    int offset = 0,
  });
}

final coordinateRepositoryProvider = Provider<CoordinateRepository>((ref) {
  return SupabaseCoordinateRepository();
});

class SupabaseCoordinateRepository implements CoordinateRepository {
  static final Map<String, List<_MemoryJobRecord>> _memoryJobsByUser = {};
  static final Map<String, List<CoordinateItem>> _memoryItemsByUser = {};
  static final Map<String, int> _memoryBalanceByUser = {};

  static const _fallbackBalance = 200;

  @override
  Future<int> getPercoinBalance({required String userId}) async {
    final service = SupabaseService.instance;
    if (service.isConfigured) {
      try {
        final response = await service.client
            .from('user_credits')
            .select('balance')
            .eq('user_id', userId)
            .maybeSingle();
        final row = response == null
            ? const <String, dynamic>{}
            : Map<String, dynamic>.from(response as Map);
        final balance = (row['balance'] as num?)?.toInt();
        if (balance != null) {
          _memoryBalanceByUser[userId] = balance;
          return balance;
        }
      } catch (_) {
        // Fall back to memory value.
      }
    }

    return _memoryBalanceByUser.putIfAbsent(userId, () => _fallbackBalance);
  }

  @override
  Future<List<CoordinateGenerationJob>> submitGeneration({
    required CoordinateGenerationRequest request,
  }) async {
    if (request.userId.trim().isEmpty) {
      throw CoordinateRepositoryFailure.unauthorized;
    }
    if (request.prompt.trim().isEmpty) {
      throw CoordinateRepositoryFailure.invalidInput;
    }

    final createdJobs = <_MemoryJobRecord>[];
    for (var index = 0; index < request.outputCount; index++) {
      final seed = DateTime.now().microsecondsSinceEpoch;
      createdJobs.add(
        _MemoryJobRecord(
          jobId: '${request.requestId}-$index-$seed',
          requestId: request.requestId,
          userId: request.userId,
          prompt: request.prompt,
          sourcePreviewUrl:
              request.sourceImageInput.stockPreviewUrl ??
              'https://picsum.photos/seed/${request.requestId}-$index/768/1024',
          startedAt: DateTime.now(),
          modelTier: request.modelTier,
          percoinCost: getPercoinCost(request.modelTier),
        ),
      );
    }

    final userJobs = _memoryJobsByUser.putIfAbsent(request.userId, () => []);
    userJobs.addAll(createdJobs);
    return createdJobs.map((record) => record.toPublicJob()).toList();
  }

  @override
  Future<List<CoordinateGenerationJob>> pollGenerationJobs({
    required String userId,
    required List<String> jobIds,
  }) async {
    final userJobs = _memoryJobsByUser[userId] ?? const [];
    final visibleJobs = userJobs
        .where((job) => jobIds.contains(job.jobId))
        .toList();

    if (visibleJobs.isEmpty) {
      return const [];
    }

    final now = DateTime.now();
    for (final job in visibleJobs) {
      if (job.status == CoordinateJobStatus.completed ||
          job.status == CoordinateJobStatus.failed) {
        continue;
      }

      final elapsed = now.difference(job.startedAt).inSeconds;
      if (elapsed < 2) {
        job.setStage(CoordinateJobStatus.queued, 6);
      } else if (elapsed < 4) {
        job.setStage(CoordinateJobStatus.processing, 28);
      } else if (elapsed < 6) {
        job.setStage(CoordinateJobStatus.generating, 62);
      } else if (elapsed < 8) {
        job.setStage(CoordinateJobStatus.uploading, 84);
      } else {
        final balance = await getPercoinBalance(userId: userId);
        if (balance < job.percoinCost) {
          job.setFailure('insufficient_balance');
          continue;
        }
        _memoryBalanceByUser[userId] = max(0, balance - job.percoinCost);
        job.complete();
        _upsertGeneratedItem(job);
      }
    }

    return visibleJobs.map((record) => record.toPublicJob()).toList();
  }

  @override
  Future<List<CoordinateGenerationJob>> recoverInProgressJobs({
    required String userId,
  }) async {
    final jobs = _memoryJobsByUser[userId] ?? const [];
    final inProgress = jobs
        .where(
          (job) =>
              job.status != CoordinateJobStatus.completed &&
              job.status != CoordinateJobStatus.failed,
        )
        .toList();
    return inProgress.map((record) => record.toPublicJob()).toList();
  }

  @override
  Future<List<CoordinateItem>> listCoordinateItems({
    required String userId,
    int limit = 20,
    int offset = 0,
  }) async {
    final service = SupabaseService.instance;
    final memoryItems = List<CoordinateItem>.from(
      _memoryItemsByUser[userId] ?? const [],
    );

    if (!service.isConfigured) {
      return _page(memoryItems, limit: limit, offset: offset);
    }

    try {
      final response = await service.client
          .from('generated_images')
          .select(
            'id, image_url, prompt, created_at, is_posted, generation_type, '
            'model, source_image_stock_id',
          )
          .eq('user_id', userId)
          .eq('generation_type', 'coordinate')
          .order('created_at', ascending: false)
          .range(0, (offset + limit + 40).clamp(0, 400));

      final rows = response as List<dynamic>;
      final remoteItems = rows
          .map(
            (row) => _mapCoordinateItem(Map<String, dynamic>.from(row as Map)),
          )
          .toList();

      final merged = _mergeItems(memoryItems, remoteItems);
      return _page(merged, limit: limit, offset: offset);
    } catch (_) {
      return _page(memoryItems, limit: limit, offset: offset);
    }
  }

  List<CoordinateItem> _page(
    List<CoordinateItem> items, {
    required int limit,
    required int offset,
  }) {
    if (offset >= items.length) {
      return const [];
    }
    final end = min(items.length, offset + limit);
    return items.sublist(offset, end);
  }

  List<CoordinateItem> _mergeItems(
    List<CoordinateItem> memoryItems,
    List<CoordinateItem> remoteItems,
  ) {
    final result = <CoordinateItem>[];
    final seen = <String>{};
    final source = [...memoryItems, ...remoteItems]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    for (final item in source) {
      if (item.id.isEmpty || seen.contains(item.id)) {
        continue;
      }
      seen.add(item.id);
      result.add(item);
    }
    return result;
  }

  CoordinateItem _mapCoordinateItem(Map<String, dynamic> row) {
    return CoordinateItem(
      id: row['id'] as String? ?? '',
      imageUrl: row['image_url'] as String? ?? '',
      prompt: row['prompt'] as String? ?? '',
      createdAt:
          DateTime.tryParse(row['created_at'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      isPosted: row['is_posted'] as bool? ?? false,
      generationType: row['generation_type'] as String? ?? 'coordinate',
      model: row['model'] as String?,
      sourceImageStockId: row['source_image_stock_id'] as String?,
    );
  }

  void _upsertGeneratedItem(_MemoryJobRecord job) {
    final userItems = _memoryItemsByUser.putIfAbsent(job.userId, () => []);
    final index = userItems.indexWhere((item) => item.id == job.jobId);
    final generatedItem = CoordinateItem(
      id: job.jobId,
      imageUrl: job.sourcePreviewUrl,
      prompt: job.prompt,
      createdAt: DateTime.now(),
      isPosted: false,
      generationType: 'coordinate',
      model: job.modelTier.name,
      sourceImageStockId: null,
    );
    if (index == -1) {
      userItems.insert(0, generatedItem);
    } else {
      userItems[index] = generatedItem;
    }
  }
}

int getPercoinCost(CoordinateModelTier modelTier) {
  return switch (modelTier) {
    CoordinateModelTier.light05k => 10,
    CoordinateModelTier.standard1k => 20,
    CoordinateModelTier.pro1k => 50,
    CoordinateModelTier.pro2k => 80,
    CoordinateModelTier.pro4k => 100,
  };
}

class _MemoryJobRecord {
  _MemoryJobRecord({
    required this.jobId,
    required this.requestId,
    required this.userId,
    required this.prompt,
    required this.sourcePreviewUrl,
    required this.startedAt,
    required this.modelTier,
    required this.percoinCost,
  }) : updatedAt = startedAt;

  final String jobId;
  final String requestId;
  final String userId;
  final String prompt;
  final String sourcePreviewUrl;
  final DateTime startedAt;
  final CoordinateModelTier modelTier;
  final int percoinCost;

  CoordinateJobStatus status = CoordinateJobStatus.queued;
  int progressPercent = 0;
  String? resultImageId;
  String? errorCode;
  DateTime updatedAt;

  void setStage(CoordinateJobStatus nextStatus, int nextProgress) {
    status = nextStatus;
    progressPercent = nextProgress;
    updatedAt = DateTime.now();
  }

  void complete() {
    status = CoordinateJobStatus.completed;
    progressPercent = 100;
    resultImageId = jobId;
    updatedAt = DateTime.now();
  }

  void setFailure(String code) {
    status = CoordinateJobStatus.failed;
    progressPercent = 100;
    errorCode = code;
    updatedAt = DateTime.now();
  }

  CoordinateGenerationJob toPublicJob() {
    return CoordinateGenerationJob(
      jobId: jobId,
      requestId: requestId,
      userId: userId,
      status: status,
      progressPercent: progressPercent,
      previewImageUrl: sourcePreviewUrl,
      resultImageId: resultImageId,
      errorCode: errorCode,
      startedAt: startedAt,
      updatedAt: updatedAt,
    );
  }
}
