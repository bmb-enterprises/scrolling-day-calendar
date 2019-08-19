# scrolling_day_calendar

A flutter calendar package for scrolling through given days as date for Android and IOS

Show some :heart and star the repo to support the project

## Screenshots
<img src="https://github.com/bmb-enterprises/scrolling-day-calendar/blob/master/sample_images/1.png" height="300em" />
<img src="https://github.com/bmb-enterprises/scrolling-day-calendar/blob/master/sample_images/2.png" height="300em" />


## Usage 

To use the plugin: 

* add the dependency to your [pubspec.yaml](https://github.com/bmb-enterprises/scrolling-day-calendar/tree/master/example)

```yaml
dependencies:
  flutter:
    sdk: flutter

  scrolling_day_calendar: 0.0.1

```

* import the package 
```dart 
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';

```

## How to use

```dart
// set the initial page value
Widget _pageItems = Text("Inital value");


// add to body
ScrollingDayCalendar(
          startDate: startDate, // Datetime object
          endDate: endDate, // Datetime object
          selectedDate: selectedDate, // Datetime object
          onDateChange: (direction, DateTime selectedDate) {
            setState(() {
              _pageItems = Text("No data"); // this will display on the new page
            });
          },
          dateStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          pageItems: _pageItems,
          dateFormat: "dd/MM/yyyy", // using the intl date format string
          dateBackgroundColor: Colors.grey,
          forwardIcon: Icons.arrow_forward,
          backwardIcon: Icons.arrow_back,
          pageChangeDuration: Duration(
            microseconds: 700,
          ),
        );
```