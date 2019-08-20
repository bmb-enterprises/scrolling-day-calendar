# scrolling_day_calendar

A flutter calendar package to allow users to scroll through given dates either by 
swiping left and right or pressing the arrows. 
The active date is displayed as a heading and the tasks for that date are displayed underneath. 
This package can be used on Android and IOS

## How it works

* Pass in the widgets method
You simply need to pass in a start date, an end date, the active date and widgets to display per day.

* SetState method
You simply need to pass in a start date, an end date, the active date and a call-back function, 
the package will then allow the user to swipe between the dates using PageView, 
on each page change the call-back you have set will be called to allow you to update the page content for the given date.


## Screenshots
<img src="https://github.com/bmb-enterprises/scrolling-day-calendar/blob/master/sample_images/1.png?raw=true" height="300em" />
<img src="https://github.com/bmb-enterprises/scrolling-day-calendar/blob/master/sample_images/2.png?raw=true" height="300em" />


## Usage 

To use the plugin: 

* add the dependency to your [pubspec.yaml](https://github.com/bmb-enterprises/scrolling-day-calendar/tree/master/example)

```yaml
dependencies:
  flutter:
    sdk: flutter

  scrolling_day_calendar: 2.0.1

```

* import the package 
```dart 
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';

```

## How to use the Widget pass-in method - recommended for better experience
```dart
DateTime selectedDate = DateTime.now();
DateTime startDate = DateTime.now().subtract(Duration(days: 10));
DateTime endDate = DateTime.now().add(Duration(days: 10));
Map<String, Widget> widgets = Map();
String widgetKeyFormat = "yyyy-MM-dd";

body: ScrollingDayCalendar(
          startDate: startDate,
          endDate: endDate,
          selectedDate: selectedDate,
          dateStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayDateFormat: "dd, MMM yyyy",
          dateBackgroundColor: Colors.grey,
          forwardIcon: Icons.arrow_forward,
          backwardIcon: Icons.arrow_back,
          pageChangeDuration: Duration(
            milliseconds: 700,
          ),
          widgets: widgets,
          widgetKeyFormat: widgetKeyFormat,
          noItemsWidget: Center(
            child: Text("No items have been added for this date"), // add buttons etc here to add new items for date
          ),
        ),
```


## How to use the SetState method

```dart
// set the initial page value
Widget _pageItems = Text("Inital value");
DateTime selectedDate = DateTime.now();
DateTime startDate = DateTime.now().subtract(Duration(days: 10));
DateTime endDate = DateTime.now().add(Duration(days: 10));
String widgetKeyFormat = "yyyy-MM-dd";

// add to body of a Scaffold
body: ScrollingDayCalendar(
          startDate: startDate,
          endDate: endDate,
          selectedDate: selectedDate,
          onDateChange: (direction, DateTime selectedDate) {
            setState(() {
              pageItems = _widgetBuilder(selectedDate);
            });
          },
          dateStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          pageItems: pageItems,
          displayDateFormat: "dd/MM/yyyy",
          dateBackgroundColor: Colors.grey,
          forwardIcon: Icons.arrow_forward,
          backwardIcon: Icons.arrow_back,
          pageChangeDuration: Duration(
            milliseconds: 400,
          ),
          noItemsWidget: Center(
            child: Text("No items have been added for this date"), // add buttons etc here to add new items for date
          ),
        ),
```