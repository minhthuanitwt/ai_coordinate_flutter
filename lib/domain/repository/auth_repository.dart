import '../../core/models/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession> restoreSession();
  Future<AuthSession> signIn({required String email, required String password});
  Future<void> signUp({required String email, required String password});
  Future<AuthSession> signOut();
}
