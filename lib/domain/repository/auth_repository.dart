import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/models/auth_session.dart';
import '../../services/local_storage_service.dart';
import '../../services/supabase_service.dart';

abstract class AuthRepository {
  Stream<AuthSession> watchSession();

  Future<AuthSession> getCurrentSession();

  Future<AuthSession> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository({required SupabaseService service}) : _service = service;

  final SupabaseService _service;
  final StreamController<AuthSession> _localSessionController =
      StreamController<AuthSession>.broadcast();

  @override
  Future<AuthSession> getCurrentSession() async {
    if (_service.isConfigured) {
      final session = _service.client.auth.currentSession;
      final user = session?.user ?? _service.client.auth.currentUser;
      if (user == null) {
        return const AuthSession.guest(source: AuthSessionSource.supabase);
      }
      return AuthSession(
        userId: user.id,
        email: user.email,
        isAuthenticated: true,
        source: AuthSessionSource.supabase,
      );
    }

    final prefs = LocalStorageService.instance;
    final active = prefs.getBool(LocalStorageService.mockSessionActiveKey) ?? false;
    final email = prefs.getString(LocalStorageService.mockUserEmailKey);
    if (!active || email == null || email.isEmpty) {
      return const AuthSession.guest();
    }

    return AuthSession(
      userId: 'mock:${email.toLowerCase()}',
      email: email,
      isAuthenticated: true,
      source: AuthSessionSource.local,
    );
  }

  @override
  Future<AuthSession> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (_service.isConfigured) {
      final response = await _service.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw AuthException('missing_user');
      }
      return AuthSession(
        userId: user.id,
        email: user.email,
        isAuthenticated: true,
        source: AuthSessionSource.supabase,
      );
    }

    final prefs = LocalStorageService.instance;
    await prefs.setBool(LocalStorageService.mockSessionActiveKey, true);
    await prefs.setString(LocalStorageService.mockUserEmailKey, email.trim());
    await prefs.setString(LocalStorageService.mockUserPasswordKey, password);

    final session = AuthSession(
      userId: 'mock:${email.trim().toLowerCase()}',
      email: email.trim(),
      isAuthenticated: true,
      source: AuthSessionSource.local,
    );
    _localSessionController.add(session);
    return session;
  }

  @override
  Future<void> signOut() async {
    if (_service.isConfigured) {
      await _service.client.auth.signOut();
      return;
    }

    final prefs = LocalStorageService.instance;
    await prefs.remove(LocalStorageService.mockSessionActiveKey);
    await prefs.remove(LocalStorageService.mockUserEmailKey);
    await prefs.remove(LocalStorageService.mockUserPasswordKey);
    _localSessionController.add(const AuthSession.guest());
  }

  @override
  Stream<AuthSession> watchSession() async* {
    yield await getCurrentSession();

    if (!_service.isConfigured) {
      yield* _localSessionController.stream;
      return;
    }

    yield* _service.client.auth.onAuthStateChange.asyncMap(
      (_) => getCurrentSession(),
    );
  }
}
