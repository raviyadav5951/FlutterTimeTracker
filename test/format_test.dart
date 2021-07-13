import 'package:new_timetracker/app/home/job_entries/format.dart';
import 'package:test/test.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  group('format', () {
    test('positive', () {
      expect(Format.hours(10), '10h');
    });

    test('zero', () {
      expect(Format.hours(0), '0h');
    });

    test('decimal', () {
      expect(Format.hours(10.00), '10h');
    });

    test('negative', () {
      expect(Format.hours(-10), '0h');
    });
  });

  group('date -Gb Locale', () {
    setUp(() async {
      Intl.defaultLocale = "en_GB";
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2021 July 8', () {
      expect(Format.date(DateTime(2021, 7, 8)), '8 July 2021');
    });
  });

  group('day of week -Gb Locale', () {
    setUp(() async {
      Intl.defaultLocale = "en_GB";
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('day of week', () {
      expect(Format.dayOfWeek(DateTime(2021, 7, 8)), 'Thu');
    });
  });

  group('Currency', () {
    test('positive ', () {
      expect(Format.currency(10), '\$10');
    });

    test('zero', () {
      expect(Format.currency(0), '');
    });

    test('negative', () {
      expect(Format.currency(-10), '-\$10');
    });

  });
}
