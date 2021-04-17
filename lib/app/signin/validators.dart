abstract class StringValidators {
  bool isValid(String value);
}

class NonEmptyValidator implements StringValidators {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidator {
  final StringValidators emailValidator = NonEmptyValidator();
  final StringValidators passwordValidator = NonEmptyValidator();
  final String emailErrorText = 'Email can\'t be empty';
  final String passwordErrorText = 'Password can\'t be empty';
}
