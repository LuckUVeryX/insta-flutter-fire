import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String email,
    required String password,
    required bool isLoading,
    required AuthException? exception,
  }) = _LoginState;

  factory LoginState.empty() {
    return const LoginState(
      email: '',
      password: '',
      exception: null,
      isLoading: false,
    );
  }
}
