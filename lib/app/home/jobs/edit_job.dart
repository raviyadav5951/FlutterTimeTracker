import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_timetracker/app/home/models/job.dart';
import 'package:new_timetracker/app/services/database.dart';
import 'package:new_timetracker/common_widgets/show_alert_dialog.dart';
import 'package:new_timetracker/common_widgets/show_exception_alert_dialog.dart';

class EditJobPage extends StatefulWidget {
  final Database database;
  final Job job;

  const EditJobPage({Key key, this.database, this.job}) : super(key: key);

  static Future<void> show(BuildContext context,
      {Database database, Job job}) async {
    await Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => EditJobPage(
              database: database,
              job: job,
            ),
        fullscreenDialog: true));
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

// Future<void> _createJob(BuildContext context) async {
//     try {
//       final database = Provider.of<Database>(context, listen: false);
//       database.createJob(Job(name: 'Blogging', ratePerHour: 10));
//     } on FirebaseException catch (e) {
//       showExceptionAlertDialog(context,
//           title: 'Operation Failed', exception: e);
//     }
//   }

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _ratePerHour;
  bool isNewJob() => widget.job == null;
  bool isLoading = false;

  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  bool validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// Before submitting a job name we check if same job name already exist
  /// We query the list of job names and compare before submit.

  Future<void> _submit() async {
    try {
      if (validateAndSaveForm()) {
        setState(() {
          isLoading = true;
        });
        final jobs = await widget.database.jobsStream().first;

        final allJobNames = jobs.map((job) => job.name).toList();
        if (!isNewJob()) {
          allJobNames.remove(widget.job.name);
        }
        if (allJobNames.contains(_name)) {
          showAlertDialog(context,
              title: 'Job Name already used',
              content: 'Please use a different job name',
              defaultActionText: 'OK');
        } else {
          final jobId =
              isNewJob() ? documentIdFromCurrentDate() : widget.job?.id;
          final job = Job(id: jobId, name: _name, ratePerHour: _ratePerHour);
          await widget.database.createOrUpdateJob(job);
          Navigator.pop(context);
        }
      }
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Operation Failed', exception: e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          isNewJob() ? 'New Job' : 'Edit Job',
        ),
        elevation: 2.0,
        actions: [
          Visibility(
            visible: !isLoading,
            child: TextButton(
              onPressed: !isLoading ? _submit : null,
              child: Text('Save'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        initialValue: _name,
        decoration: InputDecoration(labelText: 'Job Name'),
        onSaved: (value) => _name = value,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
      ),
      TextFormField(
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        decoration: InputDecoration(labelText: 'Rate per hour'),
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
        validator: (value) => value.isNotEmpty && int.tryParse(value) > 0
            ? null
            : 'Rate per hour can\'t be empty',
      ),
    ];
  }
}
