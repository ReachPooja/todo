import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, short, empty, capitalLetter, number }

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

    if (!value.contains(RegExp('[A-Z]'))) {
      return PasswordValidationError.capitalLetter;
    }
    if (!value.contains(RegExp('[0-9]'))) {
      return PasswordValidationError.number;
    }
    if (!_passwordRegExp.hasMatch(value)) {
      return PasswordValidationError.invalid;
    }

    return null;
  }
}
