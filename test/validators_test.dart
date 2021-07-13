import 'package:new_timetracker/app/signin/validators.dart';
import 'package:test/test.dart';

void main() {
  test('non empty string', () {
    final validator = NonEmptyValidator();
    expect(validator.isValid('test'), true);
    
  });
  test('empty string', () {
    final validator = NonEmptyValidator();
    expect(validator.isValid(''), false);
    
  });
  test('null string', () {
    final validator = NonEmptyValidator();
    expect(validator.isValid(null), false);
    
  });
  
}
