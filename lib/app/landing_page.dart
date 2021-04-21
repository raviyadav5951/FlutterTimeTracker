import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home_page.dart';
import 'package:new_timetracker/app/services/auth_provider.dart';
import 'signin/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  //removing this we will satisfy the Auth dependency from provider.
  // final AuthBase auth;
  // const LandingPage({Key key, @required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);

    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return HomePage();
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
