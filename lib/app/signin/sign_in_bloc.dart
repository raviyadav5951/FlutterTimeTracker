import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:new_timetracker/app/services/auth.dart';

/// We will move all the business logic other than UI in this bloc.
/// Loading state and auth methods will be moved here instead of SignInPage.

class SignInBloc {
  final AuthBase auth;

  SignInBloc({@required this.auth});

  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  //provide method to add in sink
  void _setIsLoading(bool isLoading) {
    _isLoadingController.add(isLoading);
  }

  //creating common sign in function which accepts the function as arg

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);
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
