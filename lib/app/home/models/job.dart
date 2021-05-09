import 'package:flutter/foundation.dart';

class Job {
  final String name;
  final int ratePerHour;

  Job({@required this.name, @required this.ratePerHour});

  /// add method to convert this object to Map before passing in the api.

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }

  /// same like Kotlin extension function.

  factory Job.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final int ratePerHour = data['ratePerHour'];
    return Job(name: name, ratePerHour: ratePerHour);
  }
}
