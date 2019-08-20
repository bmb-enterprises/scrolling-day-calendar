import 'package:flutter/material.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';
import 'package:example/test_data.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Day Scroller Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 200));
  DateTime endDate = DateTime.now().add(Duration(days: 200));
  Widget pageItems;
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
    pageItems = _widgetBuilder(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
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
          widgets: widgets,
          widgetKeyFormat: widgetKeyFormat,
          noItemsWidget: Center(
            child: Text("No items have been added for this date"),
          ),
        ),
      ),
    );
  }
}
