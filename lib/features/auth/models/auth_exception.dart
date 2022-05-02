import '../../../error/app_exception.dart';

// * Abstract
abstract class AuthException extends AppException {
  AuthException(String message, {this.isField = false}) : super(message);

  final bool isField;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthException &&
        other.isField == isField &&
        other.message == message;
  }

  @override
  int get hashCode => isField.hashCode;
}

abstract class AuthEmailException extends AuthException {
  AuthEmailException(String message) : super(message, isField: true);
}

abstract class AuthPasswordException extends AuthException {
  AuthPasswordException(String message) : super(message, isField: true);
}

abstract class AuthUsernameException extends AuthException {
  AuthUsernameException(String message) : super(message, isField: true);
}

// * Auth Exception
class AuthExceptionUnknown extends AuthException {
  AuthExceptionUnknown(String message) : super(message);
}

class AuthExceptionNotLoggedIn extends AuthException {
  AuthExceptionNotLoggedIn() : super('User is not logged in');
}

class AuthExceptionUserDisabled extends AuthException {
  AuthExceptionUserDisabled() : super('This account has been disabled');
}

class AuthExceptionNetworkError extends AuthException {
  AuthExceptionNetworkError() : super('Network error');
}

class AuthExceptionRegistration extends AuthException {
  AuthExceptionRegistration(String message) : super(message);
}

// * Auth Username Exception
class AuthExceptionEmptyUsername extends AuthUsernameException {
  AuthExceptionEmptyUsername() : super('Username cannot be empty');
}

// * Auth Email Exception
class AuthExceptionEmailEmpty extends AuthEmailException {
  AuthExceptionEmailEmpty() : super('Email cannot be empty');
}

class AuthExceptionUserNotFound extends AuthEmailException {
  AuthExceptionUserNotFound() : super('No account tied to this email');
}

class AuthExceptionEmailAlreadyInUse extends AuthEmailException {
  AuthExceptionEmailAlreadyInUse()
      : super('There already exists an account with the given email address');
}

class AuthExceptionInvalidEmail extends AuthEmailException {
  AuthExceptionInvalidEmail() : super('Email address is not valid');
}

// * Auth Password Exception
class AuthExceptionPasswordEmpty extends AuthPasswordException {
  AuthExceptionPasswordEmpty() : super('Password cannot empty');
}

class AuthExceptionWrongPassword extends AuthPasswordException {
  AuthExceptionWrongPassword() : super('Wrong password');
}

class AuthExceptionWeakPassword extends AuthPasswordException {
  AuthExceptionWeakPassword() : super('Password is not strong enough');
}
