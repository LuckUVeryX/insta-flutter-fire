import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../error/app_exception.dart';
import '../../../utils/logging.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return FirebaseAuthRepository(ref.watch(loggerProvider));
});

abstract class IAuthRepository {
  /// Returns the user ID for the current logged in user.
  ///
  /// Throws [AuthExceptionNotLoggedIn] if this method is called when user is
  /// not logged in.
  String get userUid;

  /// Sign up user with auth service.
  ///
  /// An [AuthException] maybe thrown if there is error signing up.
  Future<void> createUserWithEmailPassword({
    required String email,
    required String password,
  });

  /// Register user's username, bio and profile picture URL database.
  Future<void> registerUserProfile({
    required String uid,
    required String username,
    required String bio,
    required String? profilePicUrl,
  });
}

class FirebaseAuthRepository implements IAuthRepository {
  FirebaseAuthRepository(this._log);

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final Logger _log;

  static final _authExceptionMap = {
    'email-already-in-use': AuthExceptionEmailAlreadyInUse(),
    'invalid-email': AuthExceptionInvalidEmail(),
    'weak-password': AuthExceptionWeakPassword(),
  };

  @override
  String get userUid {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      _log.e('Firebase user is null');
      throw AuthExceptionNotLoggedIn();
    }
  }

  @override
  Future<void> loginUserWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginUserWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<void> createUserWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _log.i('Sign up Success');
      _log.d(cred);
    } on FirebaseAuthException catch (e) {
      _log.e(e);
      throw _authExceptionMap[e.code] ??
          AuthExceptionUnknown(e.message ?? 'Some error occurred');
    }
  }

  @override
  Future<void> registerUserProfile({
    required String uid,
    required String username,
    required String bio,
    required String? profilePicUrl,
  }) async {
    if (username.isEmpty) {
      throw AuthExceptionEmptyUsername();
    }
    try {
      await _firestore.collection('users').doc(uid).set({
        'username': username,
        'uid': uid,
        'bio': bio,
        'profilePicUrl': profilePicUrl,
        'followers': [],
        'following': [],
      });
      _log.i('Register user profile success');
    } on FirebaseException catch (e) {
      throw AuthExceptionRegistration(
        e.message ?? 'Unknown registration error',
      );
    }
  }
}

// * Auth Exceptions
abstract class AuthException extends AppException {
  AuthException(String message) : super(message);
}

class AuthExceptionUnknown extends AuthException {
  AuthExceptionUnknown(String message) : super(message);
}

class AuthExceptionNotLoggedIn extends AuthException {
  AuthExceptionNotLoggedIn() : super('User is not logged in');
}

class AuthExceptionRegistration extends AuthException {
  AuthExceptionRegistration(String message) : super(message);
}

class AuthExceptionEmailAlreadyInUse extends AuthException {
  AuthExceptionEmailAlreadyInUse()
      : super(
          'There already exists an account with the given email address',
        );
}

class AuthExceptionInvalidEmail extends AuthException {
  AuthExceptionInvalidEmail()
      : super(
          'Email address is not valid',
        );
}

class AuthExceptionWeakPassword extends AuthException {
  AuthExceptionWeakPassword()
      : super(
          'Password is not strong enough',
        );
}

class AuthExceptionEmptyUsername extends AuthException {
  AuthExceptionEmptyUsername()
      : super(
          'Username cannot be empty',
        );
}
