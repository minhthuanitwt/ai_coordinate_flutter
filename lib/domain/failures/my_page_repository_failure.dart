class MyPageRepositoryFailure implements Exception {
  const MyPageRepositoryFailure(this.code);

  final String code;
}
