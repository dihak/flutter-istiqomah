import 'package:flutter/material.dart';

class HabitDate extends StatelessWidget {
  HabitDate({Key key, this.date, this.isChecked = false, this.onChange})
      : super(key: key);

  final DateTime date;
  final bool isChecked;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    final List dayName = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    final int weekday = date.weekday - 1;
    final BoxDecoration active = BoxDecoration(
      color: Theme.of(context).primaryColor,
      shape: BoxShape.circle,
    );
    final BoxDecoration inActive = BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white),
    );

    return GestureDetector(
      onTap: () => {if (onChange != null) onChange()},
      child: Container(
        child: Column(
          children: [
            Text(dayName[weekday]),
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(top: 5),
              decoration: isChecked ? active : inActive,
              child: Center(
                child: Text(date.day.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
