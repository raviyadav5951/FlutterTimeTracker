import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:new_timetracker/app/home/models/job.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database {
  final String uid;

  /// Step 1
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  /// Step 2
  Future<void> createJob(Job job) async{
    final path = "/users/$uid/jobs/job_abc";
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(job.toMap());
  }
  
}
