import 'package:flutter/foundation.dart';
import 'package:new_timetracker/app/home/models/job.dart';
import 'package:new_timetracker/app/services/api_path.dart';
import 'package:new_timetracker/app/services/firestore_service.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  final service = FirestoreService.instance;

  /// Step 1
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  /// Step 2
  Future<void> createJob(Job job) =>
      service.setData(path: APIPath.job(uid, 'job_abc'), data: job.toMap());

  /// convert stream to type Job by using Map.
  Stream<List<Job>> jobsStream() => service.collectionStream(
      path: APIPath.jobs(uid), builder: (data) => Job.fromMap(data));
}
