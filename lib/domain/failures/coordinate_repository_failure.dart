class CoordinateRepositoryFailure implements Exception {
  const CoordinateRepositoryFailure(this.code);

  final String code;

  static const supabaseNotConfigured = CoordinateRepositoryFailure(
    'supabase_not_configured',
  );
  static const unknownError = CoordinateRepositoryFailure('unknown_error');
  static const unauthorized = CoordinateRepositoryFailure('unauthorized');
  static const invalidInput = CoordinateRepositoryFailure('invalid_input');
  static const insufficientBalance = CoordinateRepositoryFailure(
    'insufficient_balance',
  );
  static const jobPollingFailed = CoordinateRepositoryFailure(
    'job_polling_failed',
  );
  static const generationSubmitFailed = CoordinateRepositoryFailure(
    'generation_submit_failed',
  );
  static const uploadValidationFailed = CoordinateRepositoryFailure(
    'upload_validation_failed',
  );
}
