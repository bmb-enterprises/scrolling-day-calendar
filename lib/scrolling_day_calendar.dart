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
  // first date on the pages
  final DateTime startDate;
  // last date on the pages
  final DateTime endDate;
  // the active date
  final DateTime selectedDate;
  // what to do then the date changes
  final Function onDateChange;
  // page widgets to display
  final Widget pageItems;
  // date format
  final String displayDateFormat;
  // date style
  final TextStyle dateStyle;
  // background color for date container
  final Color dateBackgroundColor;
  // forward icon
  final IconData forwardIcon;
  // back icon
  final IconData backwardIcon;
  // page change duration
  final Duration pageChangeDuration;

  final Map<String, Widget> widgets;
  final Widget noItemsWidget;
  final String widgetKeyFormat;

  ScrollingDayCalendar({
    @required this.pageItems,
    @required this.startDate,
    @required this.endDate,
    @required this.selectedDate,
    this.onDateChange,
    this.widgets,
    this.noItemsWidget,
    this.widgetKeyFormat,
    this.displayDateFormat,
    this.dateStyle,
    this.dateBackgroundColor,
    this.forwardIcon,
    this.backwardIcon,
    this.pageChangeDuration,
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

    // run page update sent by user
    if (widget.onDateChange != null) {
      widget.onDateChange(direction, _selectedDate);
    }
  }

  Widget _buildPage(index) {
    DateTime dateTime = widget.startDate;
    index = index + 1;

    dateTime = widget.startDate.add(Duration(days: index));
    String key = DateFormat(widget.widgetKeyFormat).format(dateTime);

    if (widget.widgets != null && widget.widgets.containsKey(key)) {
      return widget.widgets[key];
    }

    return widget.noItemsWidget;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // set the selected date
    _selectedDate = widget.selectedDate;

    // calculate the start page
    int startingPage =
        _selectedDate.difference(widget.startDate).inDays.floor();

    setState(() {
      // set the total number of pages based on start date and end date
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
              color: widget.dateBackgroundColor != null
                  ? widget.dateBackgroundColor
                  : Colors.red,
              child: Center(
                child: MaterialButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: widget.pageChangeDuration != null
                          ? widget.pageChangeDuration
                          : Duration(microseconds: 700),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Icon(
                    widget.backwardIcon == null
                        ? Icons.arrow_back
                        : widget.backwardIcon,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 60.0,
                color: widget.dateBackgroundColor != null
                    ? widget.dateBackgroundColor
                    : Colors.red,
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Center(
                    child: Text(
                      DateFormat(widget.displayDateFormat != null
                              ? widget.displayDateFormat
                              : "dd/MM/yyyy")
                          .format(_selectedDate),
                      style: widget.dateStyle != null
                          ? widget.dateStyle
                          : TextStyle(
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
              color: widget.dateBackgroundColor != null
                  ? widget.dateBackgroundColor
                  : Colors.red,
              child: Center(
                child: MaterialButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: widget.pageChangeDuration != null
                          ? widget.pageChangeDuration
                          : Duration(milliseconds: 700),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Icon(
                    widget.forwardIcon == null
                        ? Icons.arrow_forward
                        : widget.forwardIcon,
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
            itemCount: _totalPages, // Can be null
            onPageChanged: (direction) => onPageChange(direction),
            itemBuilder: (context, index) {
              return _buildPage(index);
            },
          ),
        ),
      ],
    );
  }
}
