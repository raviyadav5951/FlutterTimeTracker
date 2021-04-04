import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onSignOut;

  const HomePage({Key key, @required this.onSignOut}) : super(key: key);

  //logout
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      onSignOut();
      print('test');
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
