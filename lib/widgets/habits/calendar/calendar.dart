import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app.dart';
import 'header.dart';
import 'date-item.dart';

class Calendar extends StatelessWidget {
  final DateTime date;

  Calendar({this.date});

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
              monthShortName[date.month - 1] + " " + date.year.toString()),
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
    // Get first date of calendar
    var firstDate = DateTime.utc(date.year, date.month, 1);
    var firstWeekInCalendar = DateTime.monday - firstDate.weekday;
    firstDate = firstDate.add(Duration(days: firstWeekInCalendar));

    // Get last date of calendar
    var lastDate = DateTime.utc(date.year, date.month + 1, 0);
    var lastWeekInCalendar = DateTime.sunday - lastDate.weekday;
    lastDate = lastDate.add(Duration(days: lastWeekInCalendar));

    // Generate widget
    List<Row> columnLists = [];
    var current = firstDate;
    var row = 0;
    var column = -1;
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
      columnLists[column].children.add(DateItem(
          date: current.day, isSecondary: date.month != current.month));

      // Increase current
      current = current.add(Duration(days: 1));
      row++;
    }

    return Column(
      children: columnLists,
    );
  }
}
