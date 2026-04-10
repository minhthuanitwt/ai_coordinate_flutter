class AuthSession {
  const AuthSession({required this.isAuthenticated, this.email});

  const AuthSession.signedOut() : this(isAuthenticated: false);

  final bool isAuthenticated;
  final String? email;

  AuthSession copyWith({bool? isAuthenticated, String? email}) {
    return AuthSession(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      email: email ?? this.email,
    );
  }
}
