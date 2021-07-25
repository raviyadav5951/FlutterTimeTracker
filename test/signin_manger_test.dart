import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:new_timetracker/app/signin/sign_in_manager.dart';
import 'package:test/test.dart';

import 'mocks.dart';

class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);
  List<T> values = [];

  @override
  set value(T newValue) {
    values.add(newValue);
    super.value = newValue;
  }
}

void main() {
  MockAuth mockAuth;
  SignInManager signInManager;
  MockValueNotifier<bool> isLoading;

  setUp(() {
    mockAuth = MockAuth();
    isLoading = MockValueNotifier<bool>(false);
    signInManager = SignInManager(auth: mockAuth, isLoading: isLoading);
  });

  test('sign-in-success', () async {
    when(mockAuth.signInAnonymously())
        .thenAnswer((_) => Future.value(MockUser.uid('123')));

    await signInManager.signInAnonymously();
    expect(isLoading.values, [true]);
  });
  test('sign-in-fail', () async {
    when(mockAuth.signInAnonymously())
        .thenThrow(PlatformException(code: 'ERROR'));
    try {
      await signInManager.signInAnonymously();
    } catch (e) {
      expect(isLoading.values, [true,false ]);
    }
  });
}
