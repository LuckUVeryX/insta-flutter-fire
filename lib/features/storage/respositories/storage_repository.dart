import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../error/app_exception.dart';
import '../../../utils/logging.dart';

final storageRepositoryProvider = Provider<IStorageRepository>((ref) {
  return FirebaseStorageRepository(ref.watch(loggerProvider));
});

abstract class IStorageRepository {
  /// Upload profile picture to storage and return its download URL.
  Future<String> uploadProfilePic({
    required String userUid,
    required Uint8List data,
  });
}

class FirebaseStorageRepository implements IStorageRepository {
  FirebaseStorageRepository(this._log);

  final _storage = FirebaseStorage.instance;
  final Logger _log;

  @override
  Future<String> uploadProfilePic({
    required String userUid,
    required Uint8List data,
  }) async {
    try {
      final ref = _storage.ref().child('profilePic').child(userUid);
      final task = ref.putData(data);
      final snapshot = await task;
      final url = await snapshot.ref.getDownloadURL();
      _log.i('Upload profile pic success');
      _log.d(url);
      return url;
    } on FirebaseException catch (e) {
      _log.e('Upload profile pic error: ${e.message}');
      throw ProfilePicStorageException(e.message);
    }
  }
}

abstract class StorageException extends AppException {
  StorageException(String message) : super(message);
}

class ProfilePicStorageException extends StorageException {
  ProfilePicStorageException([String? message])
      : super(message ?? 'Error uploading profile picture');
}
