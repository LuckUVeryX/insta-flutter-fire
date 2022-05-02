import 'package:flutter_test/flutter_test.dart';
import 'package:insta_flutter_fire/features/auth/models/models.dart';
import 'package:insta_flutter_fire/features/auth/presentation/notifiers/login_notifier.dart';
import 'package:insta_flutter_fire/features/auth/repositories/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_notifier_test.mocks.dart';

@GenerateMocks([IAuthRepository])
void main() {
  group('LoginNotifier', () {
    late MockIAuthRepository auth;
    late LoginNotifier notifier;

    setUp(() {
      auth = MockIAuthRepository();
      notifier = LoginNotifier(auth);
    });

    test('setEmail should update value of email in login state', () {
      notifier.setEmail('test email');

      expect(notifier.debugState.email, 'test email');
    });

    test('setPassword should update value of password in login state', () {
      notifier.setPassword('test password');

      expect(notifier.debugState.password, 'test password');
    });

    group('loginUserWithEmailPassword', () {
      test('should call loginUserWithEmailPassword method from IAuthRepository',
          () {
        notifier.loginUserWithEmailPassword();

        verify(auth.loginUserWithEmailPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).called(1);
      });

      test('should set loading state when trying to login', () async {
        final future = notifier.loginUserWithEmailPassword();
        expect(notifier.debugState.isLoading, true);

        await future;
        expect(notifier.debugState.isLoading, false);
      });

      test(
          'should set exception when IAuthRepository loginUserWithEmailPassword throws error',
          () async {
        when(auth.loginUserWithEmailPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenThrow(AuthExceptionUnknown('test exception'));
        await notifier.loginUserWithEmailPassword();
        expect(
          notifier.debugState.exception,
          AuthExceptionUnknown('test exception'),
        );
      });
    });
  });
}
