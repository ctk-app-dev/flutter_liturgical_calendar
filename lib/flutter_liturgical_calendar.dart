library flutter_liturgical_calendar;

import 'dart:core';

enum DayOfWeek {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

enum LiturgicalColor {
  white,
  red,
  green,
  purple,
  blue,
}

class LiturgicalDay {
  LiturgicalSeason season;
  int number;
  int? variant;
  DayOfWeek dayOfWeek;
  List<String>? tags;
  LiturgicalColor? color;

  LiturgicalDay(this.season, this.number, this.dayOfWeek,
      {this.color, this.variant, this.tags});

  void addTag(String tag) {
    tags!.add(tag);
  }

  void removeTag(String tag) {
    tags!.remove(tag);
  }

  void setVariant(int variant) {
    this.variant = variant;
  }

  LiturgicalColor? getColor() {
    return color;
  }
}

enum EasterCalculationMethod {
  anonymousGregorian,
  gauss,
  meeusJulian,
}

enum LiturgicalSeason {
  afterChristmas, // This marks the beginning of the calendar year which starts in Christmastide
  epiphany,
  septuagesima,
  sexagesima,
  quinquagesima,
  lent,
  easter,
  rogation,
  afterAscention,
  whitSunday,
  trinity,
  afterTrinity,
  beforeAdvent,
  advent,
  christmas,
}

class DateRange {
  DateTime startDate;
  DateTime endDate;

  // Constructor ensures that startDate comes before endDate
  DateRange(DateTime start, DateTime end)
      : assert(start.isBefore(end) || start.isAtSameMomentAs(end)),
        startDate = DateTime(start.year, start.month, start.day, 0, 0, 0),
        endDate = DateTime(end.year, end.month, end.day, 23, 59, 59);

  // Method to check if a specific date is within the range
  bool contains(DateTime date) {
    return (date.isAfter(startDate) || date.isAtSameMomentAs(startDate)) &&
        (date.isBefore(endDate) || date.isAtSameMomentAs(endDate));
  }
}

class LiturgicalCalendar {
  /// Calculates the date of Easter Sunday for a given year.
  /// Ref. https://en.wikipedia.org/wiki/Date_of_Easter#Anonymous_Gregorian_algorithm
  ///
  /// This function uses the Anonymous Gregorian algorithm, which is a method
  /// for computing the date of the Christian holiday of Easter based on a
  /// simplification of the Computus in the Julian calendar.
  ///
  /// The [year] parameter is the year for which to calculate Easter Sunday.
  ///
  /// Returns a [DateTime] representing Easter Sunday of the given year.
  DateTime calculateEasterAnonymousGregorian(int year) {
    int a = year % 19;
    int b = year ~/ 100;
    int c = year % 100;
    int d = b ~/ 4;
    int e = b % 4;
    int f = (b + 8) ~/ 25;
    int g = (b - f + 1) ~/ 3;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c ~/ 4;
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 11 * h + 22 * l) ~/ 451;
    int month = (h + l - 7 * m + 114) ~/ 31;
    int day = ((h + l - 7 * m + 114) % 31) + 1;

    return DateTime(year, month, day);
  }

  /// Calculates the date of Easter Sunday for a given year.
  ///
  /// This function uses either the Anonymous Gregorian algorithm or the Gauss algorithm,
  /// depending on the [method] parameter. If [method] is not provided, the function defaults
  /// to the Anonymous Gregorian algorithm.
  ///
  /// The Anonymous Gregorian algorithm is a method for computing the date of the Christian
  /// holiday of Easter based on a simplification of the Computus in the Julian calendar.
  ///
  /// The Gauss algorithm is another method for computing the date of Easter. It is similar
  /// to the Anonymous Gregorian algorithm, but with a correction for dates at the end of April.
  ///
  /// The [year] parameter is the year for which to calculate Easter Sunday.
  ///
  /// Returns a [DateTime] representing Easter Sunday of the given year.
  DateTime calculateEasterGauss(int year) {
    // Gauss Easter algorithm
    int a = year % 19;
    int b = year ~/ 100;
    int c = year % 100;
    int d = b ~/ 4;
    int e = b % 4;
    int f = (b + 8) ~/ 25;
    int g = (b - f + 1) ~/ 3;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c ~/ 4;
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 11 * h + 22 * l) ~/ 451;
    int month = (h + l - 7 * m + 114) ~/ 31;
    int day = ((h + l - 7 * m + 114) % 31) + 1;

    // Gauss correction for end of April dates
    if (month == 4 && day > 19) {
      day -= 7;
    }

    return DateTime(year, month, day);
  }

  /// Calculates the date of Easter Sunday for a given year using the Meeus Julian algorithm.
  ///
  /// The Meeus Julian algorithm is a method for computing the date of Easter based on the Julian calendar.
  /// It is named after the Belgian astronomer Jean Meeus.
  ///
  /// The [year] parameter is the year for which to calculate Easter Sunday.
  ///
  /// Returns a [DateTime] representing Easter Sunday of the given year.
  DateTime calculateEasterMeeusJulian(int year) {
    int a = year % 4;
    int b = year % 7;
    int c = year % 19;
    int d = (19 * c + 15) % 30;
    int e = (2 * a + 4 * b - d + 34) % 7;
    int month = (d + e + 114) ~/ 31;
    int day = ((d + e + 114) % 31) + 1;

    return DateTime(year, month, day);
  }

  /// Calculates the date of Easter Sunday for a given year.
  ///
  /// This function uses either the Anonymous Gregorian algorithm, the Gauss algorithm, or the Meeus Julian algorithm,
  /// depending on the [method] parameter. If [method] is not provided, the function defaults
  /// to the Anonymous Gregorian algorithm.
  ///
  /// The Anonymous Gregorian algorithm is a method for computing the date of the Christian
  /// holiday of Easter based on a simplification of the Computus in the Julian calendar.
  ///
  /// The Gauss algorithm is another method for computing the date of Easter. It is similar
  /// to the Anonymous Gregorian algorithm, but with a correction for dates at the end of April.
  ///
  /// The Meeus Julian algorithm is a method for computing the date of Easter based on the Julian calendar.
  /// It is named after the Belgian astronomer Jean Meeus.
  ///
  /// The [year] parameter is the year for which to calculate Easter Sunday.
  ///
  /// Returns a [DateTime] representing Easter Sunday of the given year.
  DateTime calculateEaster(int year, EasterCalculationMethod anonymousGregorian,
      {EasterCalculationMethod method =
          EasterCalculationMethod.anonymousGregorian}) {
    switch (method) {
      case EasterCalculationMethod.anonymousGregorian:
        return calculateEasterAnonymousGregorian(year);
      case EasterCalculationMethod.gauss:
        return calculateEasterGauss(year);
      case EasterCalculationMethod.meeusJulian:
        return calculateEasterMeeusJulian(year);
    }
  }

  Map<LiturgicalSeason, DateRange> getSeasonDateRanges(int year) {
    var easter = calculateEaster(year, EasterCalculationMethod.meeusJulian);
    var ashWednesday = easter.subtract(const Duration(days: 45));
    var sundayBeforeAshWednesday =
        ashWednesday.subtract(Duration(days: ashWednesday.weekday % 7));
    sundayBeforeAshWednesday = DateTime(year, sundayBeforeAshWednesday.month,
        sundayBeforeAshWednesday.day, 0, 0, 0);

    var christmas = DateTime(year, 12, 25);
    var sundayBeforeChristmas =
        christmas.subtract(Duration(days: christmas.weekday % 7));

    return {
      LiturgicalSeason.afterChristmas:
          DateRange(DateTime(year, 1, 1), DateTime(year, 1, 6)),
      LiturgicalSeason.epiphany: DateRange(DateTime(year, 1, 7),
          sundayBeforeAshWednesday.subtract(const Duration(days: 15))),
      LiturgicalSeason.septuagesima: DateRange(
          sundayBeforeAshWednesday.subtract(const Duration(days: 14)),
          sundayBeforeAshWednesday.subtract(const Duration(days: 8))),
      LiturgicalSeason.sexagesima: DateRange(
          sundayBeforeAshWednesday.subtract(const Duration(days: 7)),
          sundayBeforeAshWednesday.subtract(const Duration(days: 1))),
      LiturgicalSeason.quinquagesima: DateRange(sundayBeforeAshWednesday,
          sundayBeforeAshWednesday.add(const Duration(days: 6))),
      LiturgicalSeason.lent: DateRange(
        sundayBeforeAshWednesday.add(const Duration(days: 7)),
        sundayBeforeAshWednesday.add(const Duration(days: 48)),
      ),
      LiturgicalSeason.easter:
          DateRange(easter, easter.add(const Duration(days: 34))),
      LiturgicalSeason.rogation: DateRange(easter.add(const Duration(days: 35)),
          easter.add(const Duration(days: 41))),
      LiturgicalSeason.afterAscention: DateRange(
          easter.add(const Duration(days: 42)),
          easter.add(const Duration(days: 48))),
      LiturgicalSeason.whitSunday: DateRange(
          easter.add(const Duration(days: 49)),
          easter.add(const Duration(days: 55))),
      LiturgicalSeason.trinity: DateRange(
        easter.add(const Duration(days: 56)),
        easter.add(const Duration(days: 62)),
      ),
      LiturgicalSeason.afterTrinity: DateRange(
          easter.add(const Duration(days: 63)),
          sundayBeforeChristmas.subtract(const Duration(days: 29))),
      LiturgicalSeason.beforeAdvent: DateRange(
          sundayBeforeChristmas.subtract(const Duration(days: 28)),
          sundayBeforeChristmas.subtract(const Duration(days: 22))),
      LiturgicalSeason.advent: DateRange(
          sundayBeforeChristmas.subtract(const Duration(days: 21)),
          christmas.subtract(const Duration(days: 1))),
      LiturgicalSeason.christmas: DateRange(
        christmas,
        DateTime(year, 12, 31),
      ),
    };
  }

  List<LiturgicalDay> getDays(List<DateTime> dates) {
    List<LiturgicalDay> lectionaryDays = [];

    Map<int, Map<LiturgicalSeason, DateRange>> seasons = {};

    for (var date in dates) {
      if (!seasons.containsKey(date.year)) {
        seasons[date.year] = {};
      }

      if (!seasons[date.year]!.containsKey(LiturgicalSeason.easter)) {
        seasons[date.year] = getSeasonDateRanges(date.year);
      }

      // Find season date is in
      for (var season in seasons[date.year]!.keys) {
        if (seasons[date.year]![season]!.contains(date)) {
          // Calculate the number of sundays after the start of the season
          var sundayOfSeason =
              date.difference(seasons[date.year]![season]!.startDate).inDays ~/
                      7 +
                  1;

          var tags = <String>[];

          if (season == LiturgicalSeason.quinquagesima && date.weekday == 3) {
            tags += ['Ash Wednesday'];
          }

          lectionaryDays.add(LiturgicalDay(
            season,
            sundayOfSeason,
            DayOfWeek.values[date.weekday],
            tags: tags,
          ));
        }
      }
    }

    return lectionaryDays;
  }
}
