enum CoordinateJobStatus {
  queued,
  processing,
  charging,
  generating,
  uploading,
  persisting,
  completed,
  failed,
}

class CoordinateGenerationJob {
  const CoordinateGenerationJob({
    required this.jobId,
    required this.requestId,
    required this.userId,
    required this.status,
    required this.progressPercent,
    required this.startedAt,
    required this.updatedAt,
    this.previewImageUrl,
    this.resultImageId,
    this.errorCode,
  });

  final String jobId;
  final String requestId;
  final String userId;
  final CoordinateJobStatus status;
  final int progressPercent;
  final String? previewImageUrl;
  final String? resultImageId;
  final String? errorCode;
  final DateTime startedAt;
  final DateTime updatedAt;

  bool get isTerminal =>
      status == CoordinateJobStatus.completed ||
      status == CoordinateJobStatus.failed;
}
