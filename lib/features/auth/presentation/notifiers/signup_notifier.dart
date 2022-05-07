import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../image_picker/repositories/image_picker_repository.dart.dart';
import '../../../storage/models/storage_exception.dart';
import '../../../storage/respositories/storage_repository.dart';
import '../../models/models.dart';
import '../../repositories/auth_repository.dart';

final signupProvider = StateNotifierProvider<SignupNotifier, SignupInfo>((ref) {
  return SignupNotifier(
    imagePicker: ref.watch(imagePickerRepositoryProvider),
    auth: ref.watch(authRepositoryProvider),
    storage: ref.watch(storageRepositoryProvider),
  );
});

class SignupNotifier extends StateNotifier<SignupInfo> {
  SignupNotifier({
    required ImagePickerRepository imagePicker,
    required IAuthRepository auth,
    required IStorageRepository storage,
  })  : _imagePicker = imagePicker,
        _auth = auth,
        _storage = storage,
        super(SignupInfo.empty());

  final ImagePickerRepository _imagePicker;
  final IAuthRepository _auth;
  final IStorageRepository _storage;

  void setEmail(String value) {
    state = state.copyWith(email: value, exception: null);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value, exception: null);
  }

  void setUsername(String value) {
    state = state.copyWith(username: value, exception: null);
  }

  void setBio(String value) {
    state = state.copyWith(bio: value, exception: null);
  }

  Future<void> setGalleryImage() async {
    final file = await _imagePicker.pickImageFromGallery();
    state = state.copyWith(file: file, exception: null);
  }

  Future<void> setCameraImage() async {
    final file = await _imagePicker.pickImageFromCamera();
    state = state.copyWith(file: file, exception: null);
  }

  void removeImage() {
    state = state.copyWith(file: null, exception: null);
  }

  Future<void> signUpWithEmailPassword() async {
    try {
      state = state.copyWith(isLoading: true);
      await _auth.createUserWithEmailPassword(
        email: state.email,
        password: state.password,
      );

      final profilePicData = state.file;
      final String? profilePicUrl;
      if (profilePicData != null) {
        profilePicUrl = await _storage.uploadProfilePic(
          userUid: _auth.userUid,
          data: profilePicData,
        );
      } else {
        profilePicUrl = null;
      }

      await _auth.registerUserProfile(
        email: state.email,
        uid: _auth.userUid,
        username: state.username,
        bio: state.bio,
        profilePicUrl: profilePicUrl,
      );
    } on AuthException catch (e) {
      state = state.copyWith(exception: e);
    } on StorageException catch (e) {
      state = state.copyWith(exception: e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
