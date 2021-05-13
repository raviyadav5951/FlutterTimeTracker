import 'package:flutter/foundation.dart';
import 'package:new_timetracker/app/home/models/job.dart';
import 'package:new_timetracker/app/services/api_path.dart';
import 'package:new_timetracker/app/services/firestore_service.dart';

abstract class Database {
  Future<void> createOrUpdateJob(Job job);
  Stream<List<Job>> jobsStream();
  // Future<void> updateJob(Job job);
}

class FirestoreDatabase implements Database {
  final String loggedinUserid;
  final service = FirestoreService.instance;

  /// Step 1
  FirestoreDatabase({@required this.loggedinUserid})
      : assert(loggedinUserid != null);

  /// Step 2 : Create a new document on firestore db based on unique id
  Future<void> createOrUpdateJob(Job job) => service.setData(
      path: APIPath.job(loggedinUserid, job.id), data: job.toMap());

  /// convert stream to type Job by using Map.
  Stream<List<Job>> jobsStream() => service.collectionStream(
      path: APIPath.jobs(loggedinUserid),
      builder: (data, documentId) => Job.fromMap(data, documentId));
}
