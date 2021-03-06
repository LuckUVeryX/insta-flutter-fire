// Mocks generated by Mockito 5.1.0 from annotations
// in insta_flutter_fire/test/features/auth/presentation/notifiers/signup_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;
import 'dart:typed_data' as _i4;

import 'package:insta_flutter_fire/features/auth/repositories/auth_repository.dart'
    as _i5;
import 'package:insta_flutter_fire/features/image_picker/repositories/image_picker_repository.dart.dart'
    as _i2;
import 'package:insta_flutter_fire/features/storage/respositories/storage_repository.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [ImagePickerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockImagePickerRepository extends _i1.Mock
    implements _i2.ImagePickerRepository {
  MockImagePickerRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Uint8List?> pickImageFromCamera() =>
      (super.noSuchMethod(Invocation.method(#pickImageFromCamera, []),
              returnValue: Future<_i4.Uint8List?>.value())
          as _i3.Future<_i4.Uint8List?>);
  @override
  _i3.Future<_i4.Uint8List?> pickImageFromGallery() =>
      (super.noSuchMethod(Invocation.method(#pickImageFromGallery, []),
              returnValue: Future<_i4.Uint8List?>.value())
          as _i3.Future<_i4.Uint8List?>);
}

/// A class which mocks [IAuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIAuthRepository extends _i1.Mock implements _i5.IAuthRepository {
  MockIAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get userUid =>
      (super.noSuchMethod(Invocation.getter(#userUid), returnValue: '')
          as String);
  @override
  _i3.Stream<bool> get authLoginStatus =>
      (super.noSuchMethod(Invocation.getter(#authLoginStatus),
          returnValue: Stream<bool>.empty()) as _i3.Stream<bool>);
  @override
  _i3.Future<void> createUserWithEmailPassword(
          {String? email, String? password}) =>
      (super.noSuchMethod(
          Invocation.method(#createUserWithEmailPassword, [],
              {#email: email, #password: password}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> registerUserProfile(
          {String? email,
          String? uid,
          String? username,
          String? bio,
          String? profilePicUrl}) =>
      (super.noSuchMethod(
          Invocation.method(#registerUserProfile, [], {
            #email: email,
            #uid: uid,
            #username: username,
            #bio: bio,
            #profilePicUrl: profilePicUrl
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> loginUserWithEmailPassword(
          {String? email, String? password}) =>
      (super.noSuchMethod(
          Invocation.method(#loginUserWithEmailPassword, [],
              {#email: email, #password: password}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> signout() =>
      (super.noSuchMethod(Invocation.method(#signout, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}

/// A class which mocks [IStorageRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIStorageRepository extends _i1.Mock
    implements _i6.IStorageRepository {
  MockIStorageRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String> uploadProfilePic({String? userUid, _i4.Uint8List? data}) =>
      (super.noSuchMethod(
          Invocation.method(
              #uploadProfilePic, [], {#userUid: userUid, #data: data}),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
}
