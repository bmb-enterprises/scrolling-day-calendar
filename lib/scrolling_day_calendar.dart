library scrolling_day_calendar;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef ScrollingDayCalendarBuilder = Widget Function(
  BuildContext context,
  DateTime startDate,
  DateTime endDate,
  DateTime selectedDate,
  Function onDateChange,
);

class ScrollingDayCalendar extends StatefulWidget {
  final DateTime startDate; // first date on the pages
  final DateTime endDate; // last date on the pages
  final DateTime selectedDate; // the active date
  final Function onDateChange; // what to do then the date changes
  final Widget pageItems; // page widgets to display
  final Duration pageChangeDuration =
      Duration(milliseconds: 700); // page transition duration

  ScrollingDayCalendar({
    this.startDate,
    this.endDate,
    this.selectedDate,
    this.onDateChange,
    @required this.pageItems,
  });

  @override
  _ScrollingDayCalendarState createState() => _ScrollingDayCalendarState();
}

class _ScrollingDayCalendarState extends State<ScrollingDayCalendar> {
  PageController _pageController;
  int _totalPages;
  int _currentPage;
  int _previousPage;
  DateTime _selectedDate;

  onPageChange(direction) {
    _currentPage = _pageController.page.round();

    if (_currentPage > _previousPage) {
      // went forward
      DateTime newDate = _selectedDate.add(
        Duration(days: 1),
      );

      setState(() {
        _selectedDate = newDate;
      });
    } else {
      // went back
      DateTime newDate = _selectedDate.subtract(
        Duration(days: 1),
      );

      setState(() {
        _selectedDate = newDate;
      });
    }

    _previousPage = _pageController.page.round();

    widget.onDateChange(direction);
  }

  @override
  void initState() {
    _selectedDate = widget.selectedDate;
    int startingPage =
        _selectedDate.difference(widget.startDate).inDays.floor();

    setState(() {
      _totalPages = widget.endDate.difference(widget.startDate).inDays.floor();

      // set starting page
      _pageController = PageController(initialPage: startingPage);
      // set previous page
      _previousPage = startingPage;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 60.0,
              width: 60.0,
              color: Colors.red,
              child: Center(
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _pageController.previousPage(
                        duration: widget.pageChangeDuration,
                        curve: Curves.easeIn,
                      );
                    });
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 60.0,
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Center(
                    child: Text(
                      DateFormat("dd/MM/yyyy").format(_selectedDate),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 60.0,
              width: 60.0,
              color: Colors.red,
              child: Center(
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _pageController.nextPage(
                        duration: widget.pageChangeDuration,
                        curve: Curves.easeIn,
                      );
                    });
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (direction) => onPageChange(direction),
            itemBuilder: (context, index) {
              return Center(
                child: widget.pageItems,
              );
            },
            itemCount: _totalPages, // Can be null
          ),
        ),
      ],
    );
  }
}
