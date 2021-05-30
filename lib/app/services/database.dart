import 'package:flutter/foundation.dart';
import 'package:new_timetracker/app/home/models/entry.dart';
import 'package:new_timetracker/app/home/models/job.dart';
import 'package:new_timetracker/app/services/api_path.dart';
import 'package:new_timetracker/app/services/firestore_service.dart';

abstract class Database {
  Future<void> createOrUpdateJob(Job job);
  Stream<List<Job>> jobsStream();
  Stream<Job> jobStream({@required String jobId});
  Future<void> deleteJob(Job job);

  Future<void> setEntry(Entry entry);
  Future<void> deleteEntry(Entry entry);
  Stream<List<Entry>> entriesStream({Job job});
}

class FirestoreDatabase implements Database {
  final String loggedinUserid;
  final _service = FirestoreService.instance;

  /// Step 1

  FirestoreDatabase({@required this.loggedinUserid})
      : assert(loggedinUserid != null);

  /// Step 2 : Create a new document on firestore db based on unique id
  @override
  Future<void> createOrUpdateJob(Job job) => _service.setData(
      path: APIPath.job(loggedinUserid, job.id), data: job.toMap());

  /// convert stream to type Job by using Map.
  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(loggedinUserid),
      builder: (data, documentId) => Job.fromMap(data, documentId));

  /// delete data from firestore service.
  // @override
  // Future<void> deleteJob(Job job) => _service.deleteData(
  //       path: APIPath.job(loggedinUserid, job.id),
  //     );

  @override
  Stream<Job> jobStream({@required String jobId}) => _service.documentStream(
      path: APIPath.job(loggedinUserid, jobId),
      builder: (data, documentId) => Job.fromMap(data, documentId));

  @override
  Future<void> deleteJob(Job job) async {
    //First delete all entries for specific job and then delete job
    //as the entries is separate collection ,for job are not stored as subset.

    //  manually delete where entry.jobid == job.jobid
    final allentries = await entriesStream(job: job).first;
    for (Entry entry in allentries) {
      if (entry.jobId == job.id) {
        await deleteEntry(entry);
      }
    }

    // delete job
    await _service.deleteData(path: APIPath.job(loggedinUserid, job.id));
  }

  @override
  Future<void> setEntry(Entry entry) => _service.setData(
        path: APIPath.entry(loggedinUserid, entry.id),
        data: entry.toMap(),
      );

  @override
  Future<void> deleteEntry(Entry entry) => _service.deleteData(
        path: APIPath.entry(loggedinUserid, entry.id),
      );

  @override
  Stream<List<Entry>> entriesStream({Job job}) =>
      _service.collectionStream<Entry>(
        path: APIPath.entries(loggedinUserid),
        queryBuilder: job != null
            ? (query) => query.where('jobId', isEqualTo: job.id)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
