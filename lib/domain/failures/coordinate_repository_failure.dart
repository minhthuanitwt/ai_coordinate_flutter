class CoordinateRepositoryFailure implements Exception {
  const CoordinateRepositoryFailure(this.code);

  final String code;
}
