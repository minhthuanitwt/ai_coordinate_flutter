import '../../core/models/auth_session.dart';

abstract class AuthRepository {
  Stream<AuthSession> watchSession();

  Future<AuthSession> getCurrentSession();

  Future<AuthSession> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
