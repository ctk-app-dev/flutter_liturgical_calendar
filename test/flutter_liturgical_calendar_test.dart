// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

import 'package:flutter_liturgical_calendar/flutter_liturgical_calendar.dart';

class LiturgicalTestCase {
  final String description;
  final List<DateTime> days;
  final List<LiturgicalDay> expected;

  LiturgicalTestCase(this.description, this.days, this.expected);
}

class LiturgicalSeasonDateRangeTestCase {
  int year;
  Map<LiturgicalSeason, DateRange> expected;
  Map<LiturgicalSeason, List<DateTime>> spotChecks;

  LiturgicalSeasonDateRangeTestCase(this.year, this.expected, this.spotChecks);
}

void main() {
  group('Easter date calculation', () {
    // Define a list of test cases with input and expected output
    var testCases = [
      {
        'year': 2015,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2015, 4, 5)
      },
      {
        'year': 2016,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2016, 3, 27)
      },
      {
        'year': 2017,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2017, 4, 16)
      },
      {
        'year': 2018,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2018, 4, 1)
      },
      {
        'year': 2019,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2019, 4, 21)
      },
      {
        'year': 2020,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2020, 4, 12)
      },
      {
        'year': 2021,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2021, 4, 4)
      },
      {
        'year': 2022,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2022, 4, 17)
      },
      {
        'year': 2023,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2023, 4, 9)
      },
      {
        'year': 2024,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2024, 3, 31)
      },
      {
        'year': 2025,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2025, 4, 20)
      },
      {
        'year': 2026,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2026, 4, 5)
      },
      {
        'year': 2027,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2027, 3, 28)
      },
      {
        'year': 2028,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2028, 4, 16)
      },
      {
        'year': 2029,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2029, 4, 1)
      },
      {
        'year': 2030,
        'method': EasterCalculationMethod.anonymousGregorian,
        'expected': DateTime(2030, 4, 21)
      },
      {
        'year': 2015,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2015, 4, 5)
      },
      {
        'year': 2016,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2016, 3, 27)
      },
      {
        'year': 2017,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2017, 4, 16)
      },
      {
        'year': 2018,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2018, 4, 1)
      },
      {
        'year': 2019,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2019, 4, 21)
      },
      {
        'year': 2020,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2020, 4, 12)
      },
      {
        'year': 2021,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2021, 4, 4)
      },
      {
        'year': 2022,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2022, 4, 17)
      },
      {
        'year': 2023,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2023, 4, 9)
      },
      {
        'year': 2024,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2024, 3, 31)
      },
      {
        'year': 2025,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2025, 4, 20)
      },
      {
        'year': 2026,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2026, 4, 5)
      },
      {
        'year': 2027,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2027, 3, 28)
      },
      {
        'year': 2028,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2028, 4, 16)
      },
      {
        'year': 2029,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2029, 4, 1)
      },
      {
        'year': 2030,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2030, 4, 21)
      },
      {
        'year': 2015,
        'method': EasterCalculationMethod.gauss,
        'expected': DateTime(2015, 4, 5)
      },
      {
        'year': 2016,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2016, 3, 27)
      },
      {
        'year': 2017,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2017, 4, 16)
      },
      {
        'year': 2018,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2018, 4, 1)
      },
      {
        'year': 2019,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2019, 4, 21)
      },
      {
        'year': 2020,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2020, 4, 12)
      },
      {
        'year': 2021,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2021, 4, 4)
      },
      {
        'year': 2022,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2022, 4, 17)
      },
      {
        'year': 2023,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2023, 4, 9)
      },
      {
        'year': 2024,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2024, 3, 31)
      },
      {
        'year': 2025,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2025, 4, 20)
      },
      {
        'year': 2026,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2026, 4, 5)
      },
      {
        'year': 2027,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2027, 3, 28)
      },
      {
        'year': 2028,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2028, 4, 16)
      },
      {
        'year': 2029,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2029, 4, 1)
      },
      {
        'year': 2030,
        'method': EasterCalculationMethod.meeusJulian,
        'expected': DateTime(2030, 4, 21)
      },
    ];

    for (var testCase in testCases) {
      test('Easter in ${testCase['year']} using ${testCase['method']}', () {
        // Call the function with the test input and check the result
        expect(
            LiturgicalCalendar().calculateEaster(testCase['year'] as int,
                testCase['method'] as EasterCalculationMethod),
            equals(testCase['expected']));
      });
    }
  });

  group('liturgical date ranges', () {
    test('2024', () {
      var year2024 = LiturgicalCalendar().getSeasonDateRanges(2024);
      expect(
          year2024[LiturgicalSeason.quinquagesima]!
              .contains(DateTime(2024, 2, 14)),
          isTrue);
    });

    var testCases = [
      LiturgicalSeasonDateRangeTestCase(
        2024,
        {
          LiturgicalSeason.afterChristmas: DateRange(
            DateTime(2024, 1, 1),
            DateTime(2024, 1, 6),
          ),
          LiturgicalSeason.epiphany:
              DateRange(DateTime(2024, 1, 7), DateTime(2024, 1, 27)),
          LiturgicalSeason.septuagesima:
              DateRange(DateTime(2024, 1, 28), DateTime(2024, 2, 3)),
          LiturgicalSeason.sexagesima:
              DateRange(DateTime(2024, 2, 4), DateTime(2024, 2, 10)),
          LiturgicalSeason.quinquagesima:
              DateRange(DateTime(2024, 2, 11), DateTime(2024, 2, 17)),
          LiturgicalSeason.lent:
              DateRange(DateTime(2024, 2, 18), DateTime(2024, 3, 30)),
          LiturgicalSeason.easter:
              DateRange(DateTime(2024, 3, 31), DateTime(2024, 5, 4)),
          LiturgicalSeason.rogation:
              DateRange(DateTime(2024, 5, 5), DateTime(2024, 5, 11)),
          LiturgicalSeason.afterAscention:
              DateRange(DateTime(2024, 5, 12), DateTime(2024, 5, 18)),
          LiturgicalSeason.whitSunday:
              DateRange(DateTime(2024, 5, 19), DateTime(2024, 5, 25)),
          LiturgicalSeason.trinity:
              DateRange(DateTime(2024, 5, 26), DateTime(2024, 6, 1)),
          LiturgicalSeason.afterTrinity:
              DateRange(DateTime(2024, 6, 2), DateTime(2024, 11, 23)),
          LiturgicalSeason.beforeAdvent:
              DateRange(DateTime(2024, 11, 24), DateTime(2024, 11, 30)),
          LiturgicalSeason.advent:
              DateRange(DateTime(2024, 12, 1), DateTime(2024, 12, 24)),
          LiturgicalSeason.christmas:
              DateRange(DateTime(2024, 12, 25), DateTime(2024, 12, 31)),
        },
        {
          LiturgicalSeason.quinquagesima: [DateTime(2024, 2, 14)],
          LiturgicalSeason.whitSunday: [DateTime(2024, 5, 22)],
          LiturgicalSeason.beforeAdvent: [DateTime(2024, 11, 30)],
        },
      ),
      LiturgicalSeasonDateRangeTestCase(
        2025,
        {
          LiturgicalSeason.afterChristmas: DateRange(
            DateTime(2025, 1, 1),
            DateTime(2025, 1, 6),
          ),
          LiturgicalSeason.epiphany:
              DateRange(DateTime(2025, 1, 7), DateTime(2025, 2, 15)),
          LiturgicalSeason.septuagesima:
              DateRange(DateTime(2025, 2, 16), DateTime(2025, 2, 22)),
          LiturgicalSeason.sexagesima:
              DateRange(DateTime(2025, 2, 23), DateTime(2025, 3, 1)),
          LiturgicalSeason.quinquagesima:
              DateRange(DateTime(2025, 3, 2), DateTime(2025, 3, 8)),
          LiturgicalSeason.lent:
              DateRange(DateTime(2025, 3, 9), DateTime(2025, 4, 19)),
          LiturgicalSeason.easter:
              DateRange(DateTime(2025, 4, 20), DateTime(2025, 5, 24)),
          LiturgicalSeason.rogation:
              DateRange(DateTime(2025, 5, 25), DateTime(2025, 5, 31)),
          LiturgicalSeason.afterAscention:
              DateRange(DateTime(2025, 6, 1), DateTime(2025, 6, 7)),
          LiturgicalSeason.whitSunday:
              DateRange(DateTime(2025, 6, 8), DateTime(2025, 6, 14)),
          LiturgicalSeason.trinity:
              DateRange(DateTime(2025, 6, 15), DateTime(2025, 6, 21)),
          LiturgicalSeason.afterTrinity:
              DateRange(DateTime(2025, 6, 22), DateTime(2025, 11, 22)),
          LiturgicalSeason.beforeAdvent:
              DateRange(DateTime(2025, 11, 23), DateTime(2025, 11, 29)),
          LiturgicalSeason.advent:
              DateRange(DateTime(2025, 11, 30), DateTime(2025, 12, 24)),
          LiturgicalSeason.christmas:
              DateRange(DateTime(2025, 12, 25), DateTime(2025, 12, 31)),
        },
        {
          LiturgicalSeason.quinquagesima: [DateTime(2025, 3, 5)],
          LiturgicalSeason.whitSunday: [DateTime(2025, 6, 10)],
          LiturgicalSeason.beforeAdvent: [DateTime(2025, 11, 26)],
        },
      ),
    ];

    for (var testCase in testCases) {
      var dr = LiturgicalCalendar().getSeasonDateRanges(testCase.year);
      for (var season in testCase.expected.keys) {
        test('testing startDate for $season ${testCase.year}', () {
          expect(dr[season]!.startDate,
              equals(testCase.expected[season]!.startDate));
        });
        test('testing endDate for $season ${testCase.year}', () {
          expect(
              dr[season]!.endDate, equals(testCase.expected[season]!.endDate));
        });
      }
      for (var season in testCase.spotChecks.keys) {
        for (var date in testCase.spotChecks[season]!) {
          test('testing $season ${testCase.year} contains $date', () {
            expect(dr[season]!.contains(date), isTrue);
          });
        }
      }
    }
  });

  group('evaluate dates', () {
    var testCases = [
      LiturgicalTestCase('Empty date range', [], []),
      LiturgicalTestCase(
        'Before lent date ranges in 2024',
        [DateTime(2024, 2, 14)],
        [
          LiturgicalDay(LiturgicalSeason.quinquagesima, 1, DayOfWeek.wednesday,
              tags: ['Ash Wednesday'])
        ],
      ),
    ];

    for (var testCase in testCases) {
      test(testCase.description, () {
        var results = LiturgicalCalendar().getDays(testCase.days);
        expect(results.length, equals(testCase.expected.length));
        for (var i = 0; i < results.length; i++) {
          expect(results[i].season, equals(testCase.expected[i].season));
          expect(results[i].number, equals(testCase.expected[i].number));
          expect(results[i].dayOfWeek, equals(testCase.expected[i].dayOfWeek));
          expect(results[i].tags, equals(testCase.expected[i].tags));
        }
      });
    }
  });

  group('Performance evaluations', () {
    if (Platform.environment['PERF'] != 'true') {
      print('Skipping performance evaluations');
      return;
    }

    test('Easter date calculation', () {
      int year = 2022; // Test input

      // Anonymous Gregorian method
      Stopwatch stopwatch = Stopwatch()..start();
      for (int i = 0; i < 100000; i++) {
        LiturgicalCalendar()
            .calculateEaster(year, EasterCalculationMethod.anonymousGregorian);
      }
      expect(stopwatch.elapsed, lessThan(const Duration(milliseconds: 100)));
      print('Anonymous Gregorian method executed in ${stopwatch.elapsed}');

      // Gauss method
      stopwatch = Stopwatch()..start();
      for (int i = 0; i < 100000; i++) {
        LiturgicalCalendar()
            .calculateEaster(year, EasterCalculationMethod.gauss);
      }
      expect(stopwatch.elapsed, lessThan(const Duration(milliseconds: 100)));
      print('Gauss method executed in ${stopwatch.elapsed}');

      // Meus Julian method
      stopwatch = Stopwatch()..start();
      for (int i = 0; i < 100000; i++) {
        LiturgicalCalendar()
            .calculateEaster(year, EasterCalculationMethod.meeusJulian);
      }
      expect(stopwatch.elapsed, lessThan(const Duration(milliseconds: 100)));
      print('Meeus Julian method executed in ${stopwatch.elapsed}');
    });
  });
}
