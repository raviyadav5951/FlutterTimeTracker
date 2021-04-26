import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:new_timetracker/app/services/auth.dart';
import 'package:new_timetracker/app/signin/email_sign_in_model.dart';

class EmailSignInBloc {
  final AuthBase auth;

  final StreamController<EmailSignInModel> _modelController =
      StreamController();

  EmailSignInBloc({@required this.auth});

  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  /// this method is added to facilitate the addition in stream controller
  /// Because we have many attribute here (object) as compared to SignInBloc (loading state)we are
  /// using this method to add the whole object at once in the controller.
  ///
  ///As an alternative we can also create separate method for each attribute and add in stream and track them,
  ///like _setIsLoading in SignInBloc  but this is the good approach.

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isLoading: isLoading,
        submitted: submitted);

    _modelController.add(_model);
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);

    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  void toggleFormType(){
    final formType=_model.formType == EmailSignInFormType.signIn
            ? EmailSignInFormType.register
            : EmailSignInFormType.signIn;

    updateWith(
        email: '',
        password: '',
        formType:formType,
        isLoading: false,
        submitted: false);
  }
}
