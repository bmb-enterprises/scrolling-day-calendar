# scrolling_day_calendar

A flutter calendar package for scrolling through given days as date heading and display items for that day. This package can be used on Android and IOS

## How it works
You simply need to pass in a start date, an end date, the active date and a call-back function, the package will then allow 
the user to swipe between the dates using PageView, on each page change the call-back you have set will be called 
to allow you to update the page content for the given date.


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

  scrolling_day_calendar: 1.0.1

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
              print(selectedDate);
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
            milliseconds: 700,
          ),
        );
```