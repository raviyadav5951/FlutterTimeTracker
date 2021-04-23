import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/services/auth.dart';
import 'package:new_timetracker/app/signin/email_sign_in_page.dart';
import 'package:new_timetracker/app/signin/social_signin_button.dart';
import 'package:new_timetracker/common_widgets/show_exception_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'sign_in_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  /// common method to handle the exception alert dialog
  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_SIGN_IN_ABORTED') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign in Failed', exception: exception);
  }

  void setLoadingStateVisible(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    setLoadingStateVisible(true);
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } catch (e) {
      _showSignInError(context, e);
    } finally {
      setLoadingStateVisible(false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    setLoadingStateVisible(true);
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } catch (e) {
      _showSignInError(context, e);
    } finally {
      setLoadingStateVisible(false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    setLoadingStateVisible(true);
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } catch (e) {
      _showSignInError(context, e);
    } finally {
      setLoadingStateVisible(false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true, builder: (context) => EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Time tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(child: _buildHeader(),height: 50.0,),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            color: Colors.white,
            text: 'Sign in with Google',
            onPressed: _isLoading ? null :() =>  _signInWithGoogle(context),
            textColor: Colors.black87,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            color: Color(0xff334d92),
            text: 'Sign in with Facebook',
            onPressed: _isLoading ? null :() =>  _signInWithFacebook(context),
            textColor: Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            color: Colors.teal[700],
            text: 'Sign in with Email',
            onPressed: _isLoading ? null : () => _signInWithEmail(context),
            textColor: Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'or',
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            color: Colors.lime[300],
            text: 'Go Anonymous',
            onPressed: () => _signInAnonymously(context),
            textColor: Colors.black87,
          ),
        ],
      ),
    );
  }

  void showToast(String msg, BuildContext context,
      {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  /// Show loader when loading otherwise show Sign In Text
  Widget _buildHeader() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
