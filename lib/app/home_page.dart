import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/services/auth.dart';
import 'package:new_timetracker/common_widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  //logout
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context,listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    bool _didRequestSignout = await showAlertDialog(context,
        title: 'Sign out',
        content: 'Are you sure you want to sign out?',
        defaultActionText: 'Logout',
        cancelActionText: 'Cancel');
    if (_didRequestSignout) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Home Page'),
      actions: [
        TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text('Logout'),
            style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: TextStyle(color: Colors.white, fontSize: 18.0))),
      ],
    ));
  }
}
