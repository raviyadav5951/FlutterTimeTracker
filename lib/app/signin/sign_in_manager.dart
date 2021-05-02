import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:new_timetracker/app/services/auth.dart';

/// We will move all the business logic other than UI in this bloc.
/// Loading state and auth methods will be moved here instead of SignInPage.
///
/// In Branch 16_state_manage_provider we will remove the stream/streamcontroller

class SignInManager {
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  SignInManager({@required this.auth, @required this.isLoading});

  //creating common sign in function which accepts the function as arg

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  /// instead of copying the same thing in all methods we directly passed the function in _signIn as a argument.
  // Future<User> signInAnonymously() async {
  //   try {
  //     setIsLoading(true);
  //     return await auth.signInAnonymously();
  //   } catch (e) {
  //     rethrow;
  //   } finally {
  //     setIsLoading(false);
  //   }
  // }

  Future<User> signInAnonymously() async =>
      await _signIn(() => auth.signInAnonymously());

  Future<User> signInWithGoogle() async =>
      await _signIn(() => auth.signInWithGoogle());

  Future<User> signInWithFacebook() async =>
      await _signIn(() => auth.signInWithFacebook());
}
