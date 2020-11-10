import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app.dart';
import 'package:istiqomah/models/habit.dart';
import 'header.dart';
import 'date-item.dart';

class Calendar extends StatefulWidget {
  final Habit habit;
  final Function(DateTime) onToggleDate;

  Calendar({this.habit, this.onToggleDate});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime date;

  _CalendarState() : this.date = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xff559DFF),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarHeader(
            monthShortName[date.month - 1] + " " + date.year.toString(),
            onPrev: () {
              setState(() {
                date = new DateTime(date.year, date.month - 1, 1);
              });
            },
            onNext: () {
              setState(() {
                date = new DateTime(date.year, date.month + 1, 1);
              });
            },
          ),
          SizedBox(height: 10),
          Column(
            children: [
              _dateFirstRow(),
              _dateGrid(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateFirstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: Text('Sen', textAlign: TextAlign.center)),
        Expanded(child: Text('Sel', textAlign: TextAlign.center)),
        Expanded(child: Text('Rab', textAlign: TextAlign.center)),
        Expanded(child: Text('Kam', textAlign: TextAlign.center)),
        Expanded(child: Text('Jum', textAlign: TextAlign.center)),
        Expanded(child: Text('Sab', textAlign: TextAlign.center)),
        Expanded(child: Text('Min', textAlign: TextAlign.center)),
      ],
    );
  }

  Widget _dateGrid() {
    DateTime now = DateTime.now();
    // Get first date of calendar
    DateTime firstDate = DateTime.utc(date.year, date.month, 1);
    int firstWeekInCalendar = DateTime.monday - firstDate.weekday;
    firstDate = firstDate.add(Duration(days: firstWeekInCalendar));

    // Get last date of calendar
    DateTime lastDate = DateTime.utc(date.year, date.month + 1, 0);
    int lastWeekInCalendar = DateTime.sunday - lastDate.weekday;
    lastDate = lastDate.add(Duration(days: lastWeekInCalendar));

    // Generate widget
    List<Row> columnLists = [];
    DateTime current = firstDate;
    int row = 0;
    int column = -1;
    while (current.compareTo(lastDate) <= 0) {
      if (row % 7 == 0) {
        // Create row
        columnLists.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ));
        column++;
      }

      // Add dateItem Widget
      var dateWidget = DateItem(
        date: current,
        isSecondary: date.month != current.month,
        active:
            widget.habit.data.indexOf(current.toString().substring(0, 10)) !=
                -1,
        onPressed: (dateClick) {
          if (date.month != dateClick.month) {
            setState(() {
              date = new DateTime(date.year, dateClick.month, 1);
            });
          } else {
            widget.onToggleDate(dateClick);
          }
        },
        isDisabled: now.compareTo(current) < 0,
      );
      columnLists[column].children.add(dateWidget);

      // Increase current
      current = current.add(Duration(days: 1));
      row++;
    }

    return Column(
      children: columnLists,
    );
  }
}
