import 'package:flutter/material.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/pages/detail/modal/edit.dart';

class Header extends StatelessWidget {
  Header(this.habit, {this.onChange});

  final Habit habit;
  final Function(Habit) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(),
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            habit.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(),
          color: Colors.white,
          icon: Icon(Icons.edit),
          onPressed: () {
            modalEditHabit(context, habit).then(
              (value) => {onChange(habit)},
            );
          },
        ),
      ],
    );
  }
}
