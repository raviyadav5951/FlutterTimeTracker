import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home/jobs/edit_job.dart';
import 'package:new_timetracker/app/home/jobs/list_items_builder.dart';
import 'package:new_timetracker/app/home/models/job.dart';
import 'package:new_timetracker/app/services/auth.dart';
import 'package:new_timetracker/app/services/database.dart';
import 'package:new_timetracker/common_widgets/job_list_tile.dart';
import 'package:new_timetracker/common_widgets/show_alert_dialog.dart';
import 'package:new_timetracker/common_widgets/show_exception_alert_dialog.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
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

  /// delete the job
  Future<void> _deleteJob(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Operation failed', exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
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
      ),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => EditJobPage.show(context, job: null),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      initialData: [],
      builder: (context, snapshot) {
        return ListItemsBuilder(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _deleteJob(context, job),
            child: JobListTile(
              job: job,
              onTap: () => EditJobPage.show(context, job: job),
            ),
          ),
        );
      },
    );
  }
}
