import 'package:flutter/material.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';
import 'package:example/test_data.dart';
import 'package:intl/intl.dart';
import 'package:example/page_one.dart';

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 10));
  DateTime endDate = DateTime.now().add(Duration(days: 10));
  String widgetKeyFormat = "yyyy-MM-dd";
  // test data
  Map testData = TestData.getTestData();

  Widget pageItems = Center(
    child: Text("No events"),
  );

  _widgetBuilder(DateTime selectedDate) {
    String dateString = DateFormat(widgetKeyFormat).format(selectedDate);

    // find the child records in test data and build widgets
    if (testData.containsKey(dateString)) {
      List items = testData[dateString];

      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, key) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    items[key]["title"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(items[key]["description"])
                ],
              ),
            ),
          );
        },
      );
    }

    // default widget to display on the page
    return Center(
      child: Text("No events"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Examples'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Pass-in Widgets Example'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageOne()),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("SetState Example"),
        ),
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
            child: Text("No items have been added for this date"),
          ),
        ),
      ),
    );
  }
}
