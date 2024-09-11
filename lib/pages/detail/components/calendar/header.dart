import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  CalendarHeader(this.text, {this.onPrev, this.onNext});

  final String text;
  final Function? onPrev;
  final Function? onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 18,
            ),
            onPressed: onPrev as void Function()?,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 18,
            ),
            onPressed: onNext as void Function()?,
          ),
        ],
      ),
    );
  }
}
