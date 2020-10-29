import 'package:flutter/material.dart';
import 'header.dart';
import 'date-item.dart';

class Calendar extends StatelessWidget {
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
          CalendarHeader(),
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DateItem(date: 30, isSecondary: true),
            DateItem(date: 31, isSecondary: true),
            DateItem(date: 1, active: true),
            DateItem(date: 2, active: true),
            DateItem(date: 3),
            DateItem(date: 4),
            DateItem(date: 5),
          ],
        ),
      ],
    );
  }
}
