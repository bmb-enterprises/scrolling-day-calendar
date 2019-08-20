import 'package:flutter/material.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';
import 'package:example/test_data.dart';
import 'package:intl/intl.dart';
import 'package:example/page_two.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 200));
  DateTime endDate = DateTime.now().add(Duration(days: 200));

  // this date will update every time the page changes
  DateTime _currentPageDate;

  // test data
  Map testData = TestData.getTestData();
  Map<String, Widget> widgets = Map();
  String widgetKeyFormat = "yyyy-MM-dd";

  _buildPages() {
    testData.forEach((key, values) {
      DateTime dateTime = DateTime.parse(key);
      var widget = _widgetBuilder(dateTime);
      widgets.addAll({key: widget});
    });

    return widgets;
  }

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
  void initState() {
    _buildPages();
    _currentPageDate = selectedDate;
    super.initState();
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
                title: Text('SetState Example'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageTwo()),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Passing Widgets example"),
        ),
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
          onDateChange: (direction, DateTime date) {
            _currentPageDate = date;
          },
          widgets: widgets,
          widgetKeyFormat: widgetKeyFormat,
          noItemsWidget: Center(
            child: MaterialButton(
              onPressed: () {
                String formattedDate =
                    DateFormat(widgetKeyFormat).format(_currentPageDate);

                testData[formattedDate] = [
                  {
                    "title": "NEW added 1 ",
                    "description":
                        "sed ullamcorper morbi tincidunt ornare. Feugiat vivamus at augue eget arcu. Arcu cursus euismod",
                  },
                  {
                    "title": "New Added 2",
                    "description":
                        "ue. Lectus vestibulum mattis ullamcorper velit ",
                  },
                ];

                setState(() {
                  _buildPages();
                });
              },
              child: Text("Add a new Item"),
            ),
          ),
        ),
      ),
    );
  }
}
