import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:new_timetracker/app/services/auth.dart';
import 'package:new_timetracker/app/services/database.dart';
import 'package:new_timetracker/app/signin/sign_in_page.dart';
import 'package:provider/provider.dart';

class MockAuth extends Mock implements AuthBase {}

class MockDatabase extends Mock implements Database {}

class MockUser extends Mock implements User {
  MockUser();
  factory MockUser.uid(String uid) {
    final user = MockUser();
    when(user.uid).thenReturn(uid);
    return user;
  }
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  MockAuth mockAuth;
  MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockAuth = MockAuth();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  Future<void> pumpSignInPage(test.WidgetTester tester) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: Builder(
          builder: (context) => SignInPage.create(context),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    ));
    verify(mockNavigatorObserver.didPush(any, any)).called(1);
  }

  test.testWidgets('Email and password navigation',
      (test.WidgetTester tester) async {
    await pumpSignInPage(tester);

    final emailSignInButton = find.byKey(SignInPage.emailPasswordKey);

    test.expect(emailSignInButton, test.findsOneWidget);
    await tester.tap(emailSignInButton);

    await tester.pumpAndSettle();

    verify(mockNavigatorObserver.didPush(any, any)).called(1);
  });
}
