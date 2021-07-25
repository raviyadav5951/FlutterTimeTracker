import 'package:new_timetracker/app/signin/email_signin_provider/email_sign_in_change_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mocks.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInChangeModel model;

  setUp(() {
    mockAuth = MockAuth();
    model = EmailSignInChangeModel(auth: mockAuth);
  });

  test('update_email', () {
    var didNotifyListeners = false;
    model.addListener(() => didNotifyListeners = true);

    const sampleEmail = 'email@email.com';
    model.updateEmail(sampleEmail);

    expect(model.email, sampleEmail);
    expect(didNotifyListeners, true);
  });

  

}
