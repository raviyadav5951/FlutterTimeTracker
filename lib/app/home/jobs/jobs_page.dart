import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home/job_entries/job_entries_page.dart';
import 'package:new_timetracker/app/home/jobs/edit_job.dart';
import 'package:new_timetracker/app/home/jobs/list_items_builder.dart';
import 'package:new_timetracker/app/home/models/job.dart';
import 'package:new_timetracker/app/services/database.dart';
import 'package:new_timetracker/common_widgets/job_list_tile.dart';
import 'package:new_timetracker/common_widgets/show_exception_alert_dialog.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
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
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => EditJobPage.show(
              context,
              job: null,
              database: Provider.of<Database>(context, listen: false),
            ),
          ),
        ],
      ),
      body: _buildContent(context),
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
              onTap: () => JobEntriesPage.show(context, database, job),
            ),
          ),
        );
      },
    );
  }
}
