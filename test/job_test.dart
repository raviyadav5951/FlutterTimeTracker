import 'package:new_timetracker/app/home/models/job.dart';
import 'package:test/test.dart';

void main() {
  group('fromMap', () {
    test('null job', () {
      final job = Job.fromMap(null, 'abc');
      expect(job, null);
    });

    test('job with all properties', () {
      final job = Job.fromMap({
        'name': 'testjob',
        'ratePerHour': 10,
      }, 'abc_doc_id');

      expect(job, Job(id: 'abc_job_id', ratePerHour: 10, name: 'testjob'));
    });

    test('missing name', () {
      final job = Job.fromMap({
        'ratePerHour': 10,
      }, 'abc_doc_id');

      expect(job, null);
    });
  });

  group('toMap', () {
    test('valid name +ratePerHour', () {
      final job = Job(id: '113', name: 'blog', ratePerHour: 10);

      expect(job.toMap(), {'name': 'blog', 'ratePerHour': 10});
    });
  });
}
