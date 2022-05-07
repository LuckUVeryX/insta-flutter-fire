import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:insta_flutter_fire/features/auth/models/models.dart';
import 'package:insta_flutter_fire/features/auth/presentation/notifiers/signup_notifier.dart';
import 'package:insta_flutter_fire/features/auth/repositories/auth_repository.dart';
import 'package:insta_flutter_fire/features/image_picker/repositories/image_picker_repository.dart.dart';
import 'package:insta_flutter_fire/features/storage/models/storage_exception.dart';
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

    Future<Uint8List> generateDummyData() async {
      return Uint8List.fromList([1, 2, 3, 4, 5]);
    }

    test('should initialise with the correct values', () {
      final notifier = createNotifier();

      expect(notifier.debugState, SignupInfo.empty());
    });

    group('should update its state when user input', () {
      late SignupNotifier notifier;

      setUp(() => notifier = createNotifier());

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

    group('signUpWithEmailPassword', () {
      setUp(() {
        when(auth.userUid).thenReturn('test userId');
      });
      test('should update state to loading when called', () async {
        final notifier = createNotifier();

        final future = notifier.signUpWithEmailPassword();

        expect(notifier.debugState.isLoading, true);

        await future;
        expect(notifier.debugState.isLoading, false);
      });

      test('should call createUserWithEmailPassword from IAuthRepository',
          () async {
        when(auth.createUserWithEmailPassword()).thenAnswer((_) async {});
        final notifier = createNotifier();

        await notifier.signUpWithEmailPassword();

        verify(auth.createUserWithEmailPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).called(1);
      });

      test('should call registerUserProfile from IAuthRepository', () async {
        when(auth.registerUserProfile()).thenAnswer((_) async {});
        final notifier = createNotifier();

        await notifier.signUpWithEmailPassword();

        verify(auth.registerUserProfile(
          email: anyNamed('email'),
          uid: anyNamed('uid'),
          username: anyNamed('username'),
          bio: anyNamed('bio'),
          profilePicUrl: anyNamed('profilePicUrl'),
        )).called(1);
      });

      test(
          'should call uploadProfilePic from IStorageRepository and registerUserProfile from IAuthRepository with correct profilePicUrl when profile pic data is provided',
          () async {
        when(storage.uploadProfilePic(
          data: anyNamed('data'),
          userUid: anyNamed('userUid'),
        )).thenAnswer((_) async => 'test url');
        when(imagePicker.pickImageFromGallery())
            .thenAnswer((_) async => generateDummyData());
        final notifier = createNotifier();

        await notifier.setGalleryImage();
        await notifier.signUpWithEmailPassword();

        verify(storage.uploadProfilePic(
          data: await generateDummyData(),
          userUid: anyNamed('userUid'),
        )).called(1);

        verify(auth.registerUserProfile(
          email: anyNamed('email'),
          bio: anyNamed('bio'),
          uid: anyNamed('uid'),
          username: anyNamed('username'),
          profilePicUrl: 'test url',
        )).called(1);
      });

      test(
          'should not call uploadProfilePic from IStorageRepository when profile pic data is not provided',
          () async {
        when(storage.uploadProfilePic(
          data: anyNamed('data'),
          userUid: anyNamed('userUid'),
        )).thenAnswer((_) async => 'test url');

        final notifier = createNotifier();

        await notifier.signUpWithEmailPassword();

        verifyNever(storage.uploadProfilePic(
          data: await generateDummyData(),
          userUid: anyNamed('userUid'),
        ));
      });

      group('should update exception state when AuthException is thrown', () {
        late SignupNotifier notifier;
        setUp(() {
          notifier = createNotifier();
        });
        test('[AuthExceptionEmailAlreadyInUse]', () async {
          when(auth.createUserWithEmailPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          )).thenThrow(AuthExceptionEmailAlreadyInUse());

          await notifier.signUpWithEmailPassword();

          expect(
            notifier.debugState.exception,
            AuthExceptionEmailAlreadyInUse(),
          );
        });
        test('[AuthExceptionNetworkError]', () async {
          when(auth.createUserWithEmailPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          )).thenThrow(AuthExceptionNetworkError());

          await notifier.signUpWithEmailPassword();

          expect(
            notifier.debugState.exception,
            AuthExceptionNetworkError(),
          );
        });
        test('[AuthExceptionInvalidEmail]', () async {
          when(auth.createUserWithEmailPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          )).thenThrow(AuthExceptionInvalidEmail());

          await notifier.signUpWithEmailPassword();

          expect(
            notifier.debugState.exception,
            AuthExceptionInvalidEmail(),
          );
        });
        test('[AuthExceptionWeakPassword]', () async {
          when(auth.createUserWithEmailPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          )).thenThrow(AuthExceptionWeakPassword());

          await notifier.signUpWithEmailPassword();

          expect(
            notifier.debugState.exception,
            AuthExceptionWeakPassword(),
          );
        });
        test('[AuthExceptionEmptyUsername]', () async {
          when(auth.createUserWithEmailPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          )).thenThrow(AuthExceptionEmptyUsername());

          await notifier.signUpWithEmailPassword();

          expect(
            notifier.debugState.exception,
            AuthExceptionEmptyUsername(),
          );
        });
        test('[AuthExceptionRegistration]', () async {
          when(auth.registerUserProfile(
            email: anyNamed('email'),
            uid: anyNamed('uid'),
            username: anyNamed('username'),
            bio: anyNamed('bio'),
            profilePicUrl: anyNamed('profilePicUrl'),
          )).thenThrow(
              AuthExceptionRegistration('test registration exception'));

          await notifier.signUpWithEmailPassword();

          expect(
            notifier.debugState.exception,
            AuthExceptionRegistration('test registration exception'),
          );
        });
      });
      group('should update exception state when StorageException is thrown',
          () {
        late SignupNotifier notifier;
        setUp(() {
          notifier = createNotifier();
        });

        test('[ProfilePicStorageException]', () async {
          when(storage.uploadProfilePic(
                  data: anyNamed('data'), userUid: anyNamed('userUid')))
              .thenThrow(ProfilePicStorageException('test storage exception'));
          when(imagePicker.pickImageFromCamera())
              .thenAnswer((_) async => generateDummyData());

          await notifier.setCameraImage();
          await notifier.signUpWithEmailPassword();

          expect(
            notifier.debugState.exception,
            ProfilePicStorageException('test storage exception'),
          );
        });
      });
    });
  });
}
