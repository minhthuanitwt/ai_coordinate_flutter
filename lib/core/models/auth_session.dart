class AuthSession {
  const AuthSession({
    required this.userId,
    required this.email,
    required this.isAuthenticated,
    required this.source,
  });

  const AuthSession.guest({this.source = AuthSessionSource.local})
    : userId = null,
      email = null,
      isAuthenticated = false;

  final String? userId;
  final String? email;
  final bool isAuthenticated;
  final AuthSessionSource source;

  String get displayEmail => email?.trim().isNotEmpty == true ? email! : 'guest';
}

enum AuthSessionSource { local, supabase }
