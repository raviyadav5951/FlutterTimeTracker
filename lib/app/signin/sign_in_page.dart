import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/signin/social_signin_button.dart';
import 'package:toast/toast.dart';

import 'sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.onSignIn}) : super(key: key);
  final void Function(User) onSignIn;

  Future<void> _signInAnonymously() async {
    try {
    
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(userCredential.user);
      
    } catch (e) {
      print(e.toString());
    }
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
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            color: Colors.white,
            text: 'Sign in with Google',
            onPressed: () {},
            textColor: Colors.black87,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            color: Color(0xff334d92),
            text: 'Sign in with Facebook',
            onPressed: () {},
            textColor: Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            color: Colors.teal[700],
            text: 'Sign in with Email',
            onPressed: () {},
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
            onPressed: _signInAnonymously,
            textColor: Colors.black87,
          ),
        ],
      ),
    );
  }

  void showToast(String msg,BuildContext context, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
