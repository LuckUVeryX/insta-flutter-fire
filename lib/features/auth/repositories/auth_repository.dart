import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../utils/logging.dart';
import '../models/auth_exception.dart';

final authLoginStatusProvider = StreamProvider<bool>((ref) {
  return ref.watch(authRepositoryProvider).authLoginStatus;
});

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return FirebaseAuthRepository(ref.watch(loggerProvider));
});

abstract class IAuthRepository {
  /// Returns the user ID for the current logged in user.
  ///
  /// Throws [AuthExceptionNotLoggedIn] if this method is called when user is
  /// not logged in.
  String get userUid;

  /// Returns stream of bool indicating the login status.
  Stream<bool> get authLoginStatus;

  /// Sign up user with auth service.
  ///
  /// An [AuthException] maybe thrown if there is error signing up.
  Future<void> createUserWithEmailPassword({
    required String email,
    required String password,
  });

  /// Register user's username, bio and profile picture URL database.
  ///
  /// An [AuthException] maybe thrown if there is error registering.
  Future<void> registerUserProfile({
    required String uid,
    required String username,
    required String bio,
    required String? profilePicUrl,
  });

  /// Login user using email and password.
  ///
  /// An [AuthException] maybe thrown if there is error logging in.
  Future<void> loginUserWithEmailPassword({
    required String email,
    required String password,
  });

  /// Signs out the current user.
  ///
  /// If successful, it also updates any [authLoginStatus] stream listeners.
  Future<void> signout();
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
    'network-request-failed': AuthExceptionNetworkError(),
    'user-disabled': AuthExceptionUserDisabled(),
    'user-not-found': AuthExceptionUserNotFound(),
    'wrong-password': AuthExceptionWrongPassword(),
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
  Stream<bool> get authLoginStatus {
    _auth.authStateChanges().listen(_log.wtf);
    return _auth.authStateChanges().map((user) => user != null);
  }

  @override
  Future<void> loginUserWithEmailPassword({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) throw AuthExceptionEmailEmpty();
    if (password.isEmpty) throw AuthExceptionPasswordEmpty();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _log.e(e);
      throw _authExceptionMap[e.code] ??
          AuthExceptionUnknown(e.message ?? 'Some error occurred');
    }
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

  @override
  Future<void> signout() async {
    await _auth.signOut();
  }
}
