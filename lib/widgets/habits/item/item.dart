import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:istiqomah/widgets/habits/habits.dart';

const TextStyle title = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

class HabitItem extends StatefulWidget {
  HabitItem({this.habit}) : super(key: ObjectKey(habit));

  final Habit habit;

  _HabitItemState createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
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
          _header(),
          _checklist(),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Text(
        widget.habit.name,
        style: title,
      ),
    );
  }

  Widget _checklist() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _date(),
        _date(),
        _date(),
        _date(),
        _date(),
      ],
    );
  }

  Widget _date() {
    return Column(
      children: [
        Text("SEN"),
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text("20"),
          ),
        )
      ],
    );
  }
}
