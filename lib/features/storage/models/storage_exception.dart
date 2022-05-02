import '../../../error/app_exception.dart';

abstract class StorageException extends AppException {
  StorageException(String message) : super(message);
}

class ProfilePicStorageException extends StorageException {
  ProfilePicStorageException([String? message])
      : super(message ?? 'Error uploading profile picture');
}
