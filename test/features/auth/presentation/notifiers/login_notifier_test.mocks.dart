// Mocks generated by Mockito 5.1.0 from annotations
// in insta_flutter_fire/test/features/auth/presentation/notifiers/login_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:insta_flutter_fire/features/auth/repositories/auth_repository.dart'
    as _i2;
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

/// A class which mocks [IAuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIAuthRepository extends _i1.Mock implements _i2.IAuthRepository {
  MockIAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get userUid =>
      (super.noSuchMethod(Invocation.getter(#userUid), returnValue: '')
          as String);
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
          {String? uid,
          String? username,
          String? bio,
          String? profilePicUrl}) =>
      (super.noSuchMethod(
          Invocation.method(#registerUserProfile, [], {
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
}