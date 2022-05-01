import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../error/app_exception.dart';

part 'signup_state.freezed.dart';

@freezed
class SignupInfo with _$SignupInfo {
  const factory SignupInfo({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
    required AppException? exception,
  }) = _SignupInfo;

  factory SignupInfo.empty() {
    return const SignupInfo(
      email: '',
      password: '',
      username: '',
      bio: '',
      file: null,
      exception: null,
    );
  }
}
