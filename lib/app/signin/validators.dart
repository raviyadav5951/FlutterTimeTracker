abstract class StringValidators {
  bool isValid(String value);
}

class NonEmptyValidator implements StringValidators {
  @override
  bool isValid(String value) {
    if (value == null) {
      return false;
    }
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidator {
  final StringValidators emailValidator = NonEmptyValidator();
  final StringValidators passwordValidator = NonEmptyValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}
