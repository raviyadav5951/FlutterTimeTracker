import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:new_timetracker/app/home/home_page.dart';
import 'package:new_timetracker/app/landing_page.dart';
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

void main() {
  MockAuth mockAuth;
  MockDatabase mockDatabase;
  //to use stream controller in test
  StreamController<User> onAuthStateChangedController;

  setUp(() {
    mockAuth = MockAuth();
    mockDatabase = MockDatabase();
    onAuthStateChangedController = StreamController<User>();
  });

  test.tearDown(() {
    onAuthStateChangedController.close();
  });

  Future<void> pumpLandingPage(test.WidgetTester tester) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: LandingPage(
          databaseBuilder: (_)=> mockDatabase,
        ),
      ),
    ));

    await tester.pump();
  }

  void stubOnAuthStateChangedYields(Iterable<User> onAuthStateChanged) {
    //need to add in stream because we are delaing with stream
    onAuthStateChangedController
        .addStream(Stream<User>.fromIterable(onAuthStateChanged));

    when(mockAuth.authStateChanges()).thenAnswer((_) {
      return onAuthStateChangedController.stream;
    });
  }

  test.testWidgets('stream waiting so show CircularProgrss',
      (test.WidgetTester tester) async {
    stubOnAuthStateChangedYields([]);

    await pumpLandingPage(tester);
    test.expect(find.byType(CircularProgressIndicator), test.findsOneWidget);
  });

  test.testWidgets('null user', (test.WidgetTester tester) async {
    stubOnAuthStateChangedYields([null]);

    await pumpLandingPage(tester);
    test.expect(find.byType(SignInPage), test.findsOneWidget);
  });

  test.testWidgets('Non null user', (test.WidgetTester tester) async {
    stubOnAuthStateChangedYields([MockUser.uid('123')]);

    await pumpLandingPage(tester);
    test.expect(find.byType(HomePage), test.findsOneWidget);
  });
}
