import 'coordinate_source_image_input.dart';

enum CoordinateBackgroundMode { keep, includeInPrompt, aiAuto }

enum CoordinateModelTier { light05k, standard1k, pro1k, pro2k, pro4k }

class CoordinateGenerationRequest {
  const CoordinateGenerationRequest({
    required this.requestId,
    required this.userId,
    required this.sourceImageInput,
    required this.prompt,
    required this.backgroundMode,
    required this.sourceImageType,
    required this.modelTier,
    required this.outputCount,
    required this.submittedAt,
  });

  final String requestId;
  final String userId;
  final CoordinateSourceImageInput sourceImageInput;
  final String prompt;
  final CoordinateBackgroundMode backgroundMode;
  final CoordinateSourceImageType sourceImageType;
  final CoordinateModelTier modelTier;
  final int outputCount;
  final DateTime submittedAt;
}
