<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package helps you determine the Liturgical day for a given DateTime. This helps map calendar dates to the Liturgical calendar. This package was developed primarialy with the 1928 Book of Common Prayer in mind.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

```dart
import 'package:flutter_liturgical_calendar/liturgical_date.dart';

void main() {
  var date = LiturgicalDate(DateTime.now());
  print(date.liturgicalDay);
}
```

## Testing
```dart
flutter test
```

Performance profiling (for the various methods of calculating Easter)
```dart
PREF=true flutter run
```

## Additional information

This is still a work in progress. Email Wes Widner <kai5263499@gmail.com> if you have any questions or suggestions.