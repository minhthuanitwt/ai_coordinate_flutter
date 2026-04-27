enum CoordinateImageSourceMode { upload, stock }

enum CoordinateSourceImageType { illustration, real }

class CoordinateSourceImageInput {
  const CoordinateSourceImageInput({
    required this.mode,
    this.uploadFileName,
    this.uploadMimeType,
    this.uploadSizeBytes,
    this.stockImageId,
    this.stockPreviewUrl,
  });

  final CoordinateImageSourceMode mode;
  final String? uploadFileName;
  final String? uploadMimeType;
  final int? uploadSizeBytes;
  final String? stockImageId;
  final String? stockPreviewUrl;

  bool get hasSelection => switch (mode) {
    CoordinateImageSourceMode.upload =>
      (uploadFileName?.isNotEmpty ?? false) &&
          (uploadMimeType?.isNotEmpty ?? false) &&
          (uploadSizeBytes ?? 0) > 0,
    CoordinateImageSourceMode.stock => stockImageId?.isNotEmpty ?? false,
  };
}
