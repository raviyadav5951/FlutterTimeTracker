import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:new_timetracker/app/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;

  const HomePage({Key key, @required this.auth})
      : super(key: key);

  //logout
  Future<void> _signOut() async {
    try {
      await auth.signOut();
      
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Home Page'),
      actions: [
        TextButton(
            onPressed: _signOut,
            child: Text('Logout'),
            style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: TextStyle(color: Colors.white, fontSize: 18.0))),
      ],
    ));
  }
}
