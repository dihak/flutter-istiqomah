import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app_theme.dart';

class DateItem extends StatelessWidget {
  DateItem({
    this.date,
    this.active = false,
    this.isSecondary = false,
    this.onPressed,
  });

  final DateTime date;
  final bool active;
  final bool isSecondary;
  final Function(DateTime) onPressed;

  final BoxDecoration activeStyle = BoxDecoration(
    color: themeData.primaryColor,
    shape: BoxShape.circle,
  );
  final BoxDecoration inActiveStyle = BoxDecoration(
    shape: BoxShape.circle,
  );

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSecondary ? 0.7 : 1,
      child: GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed(date);
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: active ? activeStyle : inActiveStyle,
            padding: EdgeInsets.all(10),
            child: Text(
              date.day.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
