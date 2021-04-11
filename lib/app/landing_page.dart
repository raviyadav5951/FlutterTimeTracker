import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home_page.dart';
import 'package:new_timetracker/app/services/auth.dart';

import 'signin/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;

  const LandingPage({Key key, @required this.auth}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    // _updateUser(FirebaseAuth.instance.currentUser.uid);
    _getCurrentUser();
  }

  void _updateUser(User user) {
    if(user!=null){
      print('user is ${user.uid}');
    }
    setState(() {
      _user = user;
    });
  }

  _getCurrentUser() async {
    User currentUser = widget.auth.currentUser;
    setState(() {
      currentUser != null ? _user = currentUser : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    } //on sign out we pass the null
    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    );
  }
}
