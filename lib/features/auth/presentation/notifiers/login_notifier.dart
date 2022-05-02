import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/models.dart';
import '../../repositories/auth_repository.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref.watch(authRepositoryProvider));
});

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._auth) : super(LoginState.empty());

  final IAuthRepository _auth;

  void setEmail(String value) {
    state = state.copyWith(email: value, exception: null);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value, exception: null);
  }

  Future<void> loginUserWithEmailPassword() async {
    try {
      state = state.copyWith(isLoading: true);
      await _auth.loginUserWithEmailPassword(
        email: state.email,
        password: state.password,
      );
    } on AuthException catch (e) {
      state = state.copyWith(exception: e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
