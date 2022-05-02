// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'signup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignupInfo {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  Uint8List? get file => throw _privateConstructorUsedError;
  AppException? get exception => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignupInfoCopyWith<SignupInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupInfoCopyWith<$Res> {
  factory $SignupInfoCopyWith(
          SignupInfo value, $Res Function(SignupInfo) then) =
      _$SignupInfoCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String password,
      String username,
      String bio,
      Uint8List? file,
      AppException? exception,
      bool isLoading});
}

/// @nodoc
class _$SignupInfoCopyWithImpl<$Res> implements $SignupInfoCopyWith<$Res> {
  _$SignupInfoCopyWithImpl(this._value, this._then);

  final SignupInfo _value;
  // ignore: unused_field
  final $Res Function(SignupInfo) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? username = freezed,
    Object? bio = freezed,
    Object? file = freezed,
    Object? exception = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      bio: bio == freezed
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      exception: exception == freezed
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$SignupInfoCopyWith<$Res> implements $SignupInfoCopyWith<$Res> {
  factory _$SignupInfoCopyWith(
          _SignupInfo value, $Res Function(_SignupInfo) then) =
      __$SignupInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String password,
      String username,
      String bio,
      Uint8List? file,
      AppException? exception,
      bool isLoading});
}

/// @nodoc
class __$SignupInfoCopyWithImpl<$Res> extends _$SignupInfoCopyWithImpl<$Res>
    implements _$SignupInfoCopyWith<$Res> {
  __$SignupInfoCopyWithImpl(
      _SignupInfo _value, $Res Function(_SignupInfo) _then)
      : super(_value, (v) => _then(v as _SignupInfo));

  @override
  _SignupInfo get _value => super._value as _SignupInfo;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? username = freezed,
    Object? bio = freezed,
    Object? file = freezed,
    Object? exception = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_SignupInfo(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      bio: bio == freezed
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      exception: exception == freezed
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SignupInfo implements _SignupInfo {
  const _$_SignupInfo(
      {required this.email,
      required this.password,
      required this.username,
      required this.bio,
      required this.file,
      required this.exception,
      required this.isLoading});

  @override
  final String email;
  @override
  final String password;
  @override
  final String username;
  @override
  final String bio;
  @override
  final Uint8List? file;
  @override
  final AppException? exception;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'SignupInfo(email: $email, password: $password, username: $username, bio: $bio, file: $file, exception: $exception, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignupInfo &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.bio, bio) &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other.exception, exception) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(bio),
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(exception),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$SignupInfoCopyWith<_SignupInfo> get copyWith =>
      __$SignupInfoCopyWithImpl<_SignupInfo>(this, _$identity);
}

abstract class _SignupInfo implements SignupInfo {
  const factory _SignupInfo(
      {required final String email,
      required final String password,
      required final String username,
      required final String bio,
      required final Uint8List? file,
      required final AppException? exception,
      required final bool isLoading}) = _$_SignupInfo;

  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get password => throw _privateConstructorUsedError;
  @override
  String get username => throw _privateConstructorUsedError;
  @override
  String get bio => throw _privateConstructorUsedError;
  @override
  Uint8List? get file => throw _privateConstructorUsedError;
  @override
  AppException? get exception => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SignupInfoCopyWith<_SignupInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
