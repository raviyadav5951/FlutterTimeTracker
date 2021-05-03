import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:new_timetracker/app/home/models/job.dart';
import 'package:new_timetracker/app/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database {
  final String uid;

  /// Step 1
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  /// Step 2
  Future<void> createJob(Job job) =>
      _setData(path: APIPath.job(uid, 'job_abc'),data:job.toMap());

  /// generic method to set the data
  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final documentReference = FirebaseFirestore.instance.doc(path);
    print('$path : $data');
    await documentReference.set(data);
  }
}
