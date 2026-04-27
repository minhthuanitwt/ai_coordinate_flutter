import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/coordinate_generation_job.dart';
import '../../../domain/models/coordinate_generation_request.dart';
import '../../../domain/models/coordinate_item.dart';
import '../../../domain/models/coordinate_polling_recovery_state.dart';
import '../../../domain/models/coordinate_source_image_input.dart';

part 'coordinate_state.freezed.dart';

@freezed
class CoordinateState with _$CoordinateState {
  const CoordinateState._();

  const factory CoordinateState({
    required List<CoordinateItem> items,
    required bool isLoadingInitial,
    required bool isLoadingMore,
    required bool isSubmitting,
    required bool hasMore,
    required bool requiresAuth,
    required String prompt,
    required CoordinateImageSourceMode sourceMode,
    required CoordinateSourceImageType sourceImageType,
    required CoordinateBackgroundMode backgroundMode,
    required CoordinateModelTier modelTier,
    required int outputCount,
    required int maxOutputCount,
    required int percoinBalance,
    required int estimatedPercoinCost,
    required CoordinateSourceImageInput sourceInput,
    required List<CoordinateGenerationJob> activeJobs,
    required CoordinatePollingRecoveryState pollingRecovery,
    String? errorCode,
    String? submitErrorCode,
    String? validationErrorCode,
    String? infoMessageCode,
  }) = _CoordinateState;

  factory CoordinateState.initial() => CoordinateState(
    items: const [],
    isLoadingInitial: true,
    isLoadingMore: false,
    isSubmitting: false,
    hasMore: true,
    requiresAuth: false,
    prompt: '',
    sourceMode: CoordinateImageSourceMode.upload,
    sourceImageType: CoordinateSourceImageType.illustration,
    backgroundMode: CoordinateBackgroundMode.keep,
    modelTier: CoordinateModelTier.light05k,
    outputCount: 1,
    maxOutputCount: 2,
    percoinBalance: 0,
    estimatedPercoinCost: 1,
    sourceInput: const CoordinateSourceImageInput(
      mode: CoordinateImageSourceMode.upload,
    ),
    activeJobs: const [],
    pollingRecovery: const CoordinatePollingRecoveryState.initial(),
    errorCode: null,
    submitErrorCode: null,
    validationErrorCode: null,
    infoMessageCode: null,
  );

  bool get hasActiveJobs => activeJobs.any((job) => !job.isTerminal);
}
