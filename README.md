## flutter_liturgical_calendar

This package helps you determine the Liturgical day for a given DateTime. This helps map calendar dates to the Liturgical calendar. This package was developed primarily with the 1928 Book of Common Prayer in mind. [1][2]

### Usage

To use this package, import the `liturgical_date.dart` file and create a `LiturgicalDate` object with the desired `DateTime`:

```dart
import 'package:flutter_liturgical_calendar/liturgical_date.dart';

void main() {
  var date = LiturgicalDate(DateTime.now());
  print(date.liturgicalDay);
}