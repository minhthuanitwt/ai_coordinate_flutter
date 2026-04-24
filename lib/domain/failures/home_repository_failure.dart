class HomeRepositoryFailure implements Exception {
  const HomeRepositoryFailure(this.code);

  final String code;
}
