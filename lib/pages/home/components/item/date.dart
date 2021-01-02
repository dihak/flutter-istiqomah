import 'package:flutter/material.dart';

class HabitDate extends StatelessWidget {
  HabitDate({Key key, this.date, this.isChecked = false, this.onChange})
      : super(key: key);

  final DateTime date;
  final bool isChecked;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    final List dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final int weekday = date.weekday - 1;
    final BoxDecoration active = BoxDecoration(
      color: Theme.of(context).primaryColor,
      shape: BoxShape.circle,
    );
    final BoxDecoration inActive =
        BoxDecoration(color: Colors.white12, shape: BoxShape.circle);

    return GestureDetector(
      onTap: () => {if (onChange != null) onChange()},
      child: Container(
        child: Column(
          children: [
            Text(
              dayName[weekday],
              style: TextStyle(fontSize: 14),
            ),
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(top: 5),
              decoration: isChecked ? active : inActive,
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
