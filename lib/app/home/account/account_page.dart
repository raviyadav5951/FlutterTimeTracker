import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/services/auth.dart';
import 'package:new_timetracker/common_widgets/avatar.dart';
import 'package:new_timetracker/common_widgets/show_alert_dialog.dart';
import 'package:new_timetracker/common_widgets/show_exception_alert_dialog.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  //logout
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Operation Failed', exception: e);
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
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text('Logout'),
            style: TextButton.styleFrom(
              primary: Colors.white,
              textStyle: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ],
        bottom: PreferredSize(
            child: _buildUserInfo(auth.currentUser),
            preferredSize: Size.fromHeight(130)),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Avatar(radius: 50, photoUrl: user.photoURL),
        SizedBox(height: 8.0),
        if(user.displayName!=null)
          Text(user.displayName,
          style:TextStyle(color: Colors.white)),

          SizedBox(height: 8.0),
      ],
    );
  }
}
