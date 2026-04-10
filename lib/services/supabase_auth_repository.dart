import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/models/auth_session.dart';
import '../domain/repository/auth_repository.dart';
import 'local_storage_service.dart';
import 'supabase_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return SupabaseAuthRepository();
});

class SupabaseAuthRepository implements AuthRepository {
  @override
  Future<AuthSession> restoreSession() async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      final prefs = LocalStorageService.instance;
      return AuthSession(
        isAuthenticated:
            prefs.getBool(LocalStorageService.mockSessionActiveKey) ?? false,
        email: prefs.getString(LocalStorageService.mockUserEmailKey),
      );
    }

    final session = service.client.auth.currentSession;
    return AuthSession(
      isAuthenticated: session != null,
      email: session?.user.email,
    );
  }

  @override
  Future<AuthSession> signIn({
    required String email,
    required String password,
  }) async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      final prefs = LocalStorageService.instance;
      await prefs.setString(LocalStorageService.mockUserEmailKey, email);
      await prefs.setString(LocalStorageService.mockUserPasswordKey, password);
      await prefs.setBool(LocalStorageService.mockSessionActiveKey, true);
      return AuthSession(isAuthenticated: true, email: email);
    }

    final response = await service.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return AuthSession(
      isAuthenticated: response.session != null,
      email: response.user?.email ?? email,
    );
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      final prefs = LocalStorageService.instance;
      await prefs.setString(LocalStorageService.mockUserEmailKey, email);
      await prefs.setString(LocalStorageService.mockUserPasswordKey, password);
      await prefs.setBool(LocalStorageService.mockSessionActiveKey, false);
      return;
    }

    await service.client.auth.signUp(email: email, password: password);
  }

  @override
  Future<AuthSession> signOut() async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      await LocalStorageService.instance.setBool(
        LocalStorageService.mockSessionActiveKey,
        false,
      );
      return const AuthSession.signedOut();
    }

    await service.client.auth.signOut();
    return const AuthSession.signedOut();
  }
}
