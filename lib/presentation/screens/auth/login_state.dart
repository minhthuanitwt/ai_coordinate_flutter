import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String email,
    required String password,
    required bool isSubmitting,
    String? errorCode,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(
    email: '',
    password: '',
    isSubmitting: false,
    errorCode: null,
  );
}
