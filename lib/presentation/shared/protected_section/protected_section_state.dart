class ProtectedSectionState {
  const ProtectedSectionState({
    required this.isAuthenticated,
    required this.isRedirecting,
  });

  final bool isAuthenticated;
  final bool isRedirecting;
}
