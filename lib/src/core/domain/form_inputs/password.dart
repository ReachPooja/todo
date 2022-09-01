import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, short, empty }

/// Form input for validation of password
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    if (value.length < 8) {
      return PasswordValidationError.short;
    }
    if (!_passwordRegExp.hasMatch(value)) {
      return PasswordValidationError.invalid;
    }

    return null;
  }
}
