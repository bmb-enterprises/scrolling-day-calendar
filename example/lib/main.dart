import 'package:flutter/material.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';
import 'dart:math';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  DateTime startDate = DateTime.now().subtract(Duration(days: 10));
  DateTime endDate = DateTime.now().add(Duration(days: 10));

  Widget pageItems = Center(
    child: Text("No events"),
  );

  randomWidget() {
    List widgets = [
      ListView(
        children: <Widget>[
          Text("Hey"),
          Text("Hey"),
          Text("Hey"),
        ],
      ),
      ListView(
        children: <Widget>[
          Text("Pee"),
          Text("Pee"),
          Text("Pee"),
        ],
      ),
      Center(
        child: Text("No events"),
      )
    ];

    int min = 0;
    int max = widgets.length;
    Random rnd = new Random();
    var r = min + rnd.nextInt(max - min);

    return widgets[r];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ScrollingDayCalendar(
        startDate: startDate,
        endDate: endDate,
        selectedDate: selectedDate,
        onDateChange: (date) {
          //print(date);
          setState(() {
            pageItems = randomWidget();
          });
        },
        pageItems: pageItems,
      ),
    );
  }
}
