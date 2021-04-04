import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home_page.dart';

import 'signin/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;
  String _uid;


  @override
  void initState() {
    super.initState();
    // _updateUser(FirebaseAuth.instance.currentUser.uid);
    _getCurrentUser();
  }

  void _updateUser(User user) {
    print('user is ${user.uid}');
    setState(() {
      // _uid = uid;
      _user = user;
    });
  }

  _getCurrentUser() async {
    User currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      // currentUser != null ? _uid = currentUser.uid : null;
      currentUser != null ? _user = currentUser : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        onSignIn: _updateUser,
      );
    } //on sign out we pass the null
    return HomePage(
      onSignOut: () => _updateUser(null),
    );
  }
}
