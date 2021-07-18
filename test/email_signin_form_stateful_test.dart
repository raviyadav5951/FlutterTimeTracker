import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:new_timetracker/app/services/auth.dart';
import 'package:new_timetracker/app/signin/email_sign_in_form_stateful.dart';
import 'package:provider/provider.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {
  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(test.WidgetTester tester,
      {VoidCallback onSignedIn}) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: Scaffold(
          body: EmailSignInFormStateful(
            onSignedIn: onSignedIn,
          ),
        ),
      ),
    ));
  }

  test.group('sign in', () {
    test.testWidgets(
        'WHEN user doesn\'t enter email and password'
        'AND user taps on sign in button'
        'THEN signInWithEmailAndPassword is never called'
        'AND user is not signed-in', (test.WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);
      final signInButton = test.find.text('Sign In');

      await tester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
      test.expect(signedIn, false);
    });

    test.testWidgets(
        'WHEN user enter email and password'
        'AND user taps on sign in button'
        'THEN signInWithEmailAndPassword is called'
        'AND user is signed in', (test.WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      const email = 'email@email.com';
      const password = 'password';

      final emailField = test.find.byKey(Key('email'));
      expect(emailField, test.findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = test.find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      //to rebuild in case of test environment because widgets not rebuilt in case of test
      await tester.pump();

      //waits for any animation
      // await tester.pumpAndSettle();

      final signInButton = test.find.text('Sign In');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, true);
    });
  });

  test.group('register', () {
    test.testWidgets(
        'WHEN user taps on secondary button'
        'THEN form toggles to registration mode',
        (test.WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      //first find the secondary button
      final secondaryButton = find.text('Need an account? Register.');
      await tester.tap(secondaryButton);
      await tester.pump(); //to rebuild

      //here we expect that primary text changes to 'Create an account'
      final createAccountButton = find.text('Create an account');
      test.expect(createAccountButton, test.findsOneWidget);
    });

    test.testWidgets(
        'WHEN user taps on secondary button '
        'AND user enter email and password'
        'AND user taps on sign in button'
        'THEN createUserWithEmailAndPassword is called',
        (test.WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      //first find the secondary button
      final secondaryButton = find.text('Need an account? Register.');
      await tester.tap(secondaryButton);
      await tester.pump(); //to rebuild

      //here we expect that primary text changes to 'Create an account'
      final createAccountButton = find.text('Create an account');
      test.expect(createAccountButton, test.findsOneWidget);

      // condition 1 i.e tapping on secondary button moves to register mode ,is covered.

      const email = 'email@email.com';
      const password = 'password';

      final emailField = test.find.byKey(Key('email'));
      expect(emailField, test.findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = test.find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      //to rebuild in case of test environment because widgets not rebuilt in case of test
      await tester.pump();

      //condition 2 i.e user and email entered covered

      //waits for any animation
      // await tester.pumpAndSettle();

      //condition 3 i.e create account tapped
      await tester.tap(createAccountButton);

      //condition 4 i.e createUserWithEmailAndPassword called
      verify(mockAuth.createUserWithEmailAndPassword(email, password))
          .called(1);
    });
  });
}
