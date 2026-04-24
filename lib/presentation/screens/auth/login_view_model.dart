import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../presentation/providers/auth_session_provider.dart';
import 'login_state.dart';

final loginViewModelProvider =
    AutoDisposeNotifierProvider<LoginViewModel, LoginState>(
      LoginViewModel.new,
    );

class LoginViewModel extends AutoDisposeNotifier<LoginState> {
  @override
  LoginState build() {
    return LoginState.initial();
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value, errorCode: null);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value, errorCode: null);
  }

  Future<bool> signIn() async {
    final email = state.email.trim();
    final password = state.password;

    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(errorCode: 'missing_credentials');
      return false;
    }

    state = state.copyWith(isSubmitting: true, errorCode: null);
    try {
      await ref
          .read(authRepositoryProvider)
          .signInWithEmail(email: email, password: password);
      state = state.copyWith(isSubmitting: false, errorCode: null);
      return true;
    } on AuthException catch (error) {
      state = state.copyWith(
        isSubmitting: false,
        errorCode: error.message.isEmpty ? 'sign_in_failed' : error.message,
      );
      return false;
    } catch (_) {
      state = state.copyWith(isSubmitting: false, errorCode: 'sign_in_failed');
      return false;
    }
  }
}
