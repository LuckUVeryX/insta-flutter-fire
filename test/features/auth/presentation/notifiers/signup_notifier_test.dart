import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:insta_flutter_fire/features/auth/models/models.dart';
import 'package:insta_flutter_fire/features/auth/presentation/notifiers/signup_notifier.dart';
import 'package:insta_flutter_fire/features/auth/repositories/auth_repository.dart';
import 'package:insta_flutter_fire/features/image_picker/repositories/image_picker_repository.dart.dart';
import 'package:insta_flutter_fire/features/storage/respositories/storage_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_notifier_test.mocks.dart';

@GenerateMocks([ImagePickerRepository, IAuthRepository, IStorageRepository])
void main() {
  group('SignupNotifier', () {
    late MockImagePickerRepository imagePicker;
    late MockIAuthRepository auth;
    late MockIStorageRepository storage;

    setUp(() {
      imagePicker = MockImagePickerRepository();
      auth = MockIAuthRepository();
      storage = MockIStorageRepository();
    });

    SignupNotifier createNotifier() {
      return SignupNotifier(
          imagePicker: imagePicker, auth: auth, storage: storage);
    }

    test('should initialise with the correct values', () {
      final notifier = createNotifier();

      expect(notifier.debugState, SignupInfo.empty());
    });

    group('should update its state when user input', () {
      late SignupNotifier notifier;

      setUp(() => notifier = createNotifier());

      Future<Uint8List> generateDummyData() async {
        return Uint8List.fromList([1, 2, 3, 4, 5]);
      }

      test('email', () {
        notifier.setEmail('test email');

        expect(notifier.debugState.email, 'test email');
      });
      test('password', () {
        notifier.setPassword('test password');

        expect(notifier.debugState.password, 'test password');
      });
      test('username', () {
        notifier.setUsername('test username');

        expect(notifier.debugState.username, 'test username');
      });
      test('bio', () {
        notifier.setBio('test bio');

        expect(notifier.debugState.bio, 'test bio');
      });
      test('galleryImage', () async {
        when(imagePicker.pickImageFromGallery())
            .thenAnswer((_) async => generateDummyData());

        await notifier.setGalleryImage();

        verify(imagePicker.pickImageFromGallery()).called(1);
        expect(notifier.debugState.file, await generateDummyData());
      });
      test('cameraImage', () async {
        when(imagePicker.pickImageFromCamera())
            .thenAnswer((_) async => generateDummyData());

        await notifier.setCameraImage();

        verify(imagePicker.pickImageFromCamera()).called(1);
        expect(notifier.debugState.file, await generateDummyData());
      });
      test('removeImage', () async {
        when(imagePicker.pickImageFromCamera())
            .thenAnswer((_) async => generateDummyData());

        expect(notifier.debugState.file, null);

        await notifier.setCameraImage();
        verify(imagePicker.pickImageFromCamera()).called(1);
        expect(notifier.debugState.file, await generateDummyData());

        notifier.removeImage();
        expect(notifier.debugState.file, null);
      });
    });
  });
}
