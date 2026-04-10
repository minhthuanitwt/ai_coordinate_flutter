import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/models/auth_session.dart';
import '../../../services/supabase_auth_repository.dart';

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, AuthSession>(
  AuthViewModel.new,
);

class AuthViewModel extends AsyncNotifier<AuthSession> {
  @override
  Future<AuthSession> build() async {
    return ref.read(authRepositoryProvider).restoreSession();
  }

  Future<bool> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password),
    );
    return state.valueOrNull?.isAuthenticated ?? false;
  }

  Future<void> signUp({required String email, required String password}) async {
    await ref
        .read(authRepositoryProvider)
        .signUp(email: email, password: password);
    state = AsyncValue.data(AuthSession(isAuthenticated: false, email: email));
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(ref.read(authRepositoryProvider).signOut);
  }
}
