import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:new_timetracker/app/signin/sign_in_button.dart';
import 'package:new_timetracker/app/signin/social_signin_button.dart';
import 'package:new_timetracker/common_widgets/custom_elevated_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Time tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
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
          SocialSignInButton(
            assetName: '',
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
          SocialSignInButton(
            assetName: '',
            color: Colors.lime[300],
            text: 'Go Anonymous',
            onPressed: () {},
            textColor: Colors.black87,
          ),
        ],
      ),
    );
  }
}
