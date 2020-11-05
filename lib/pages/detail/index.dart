import 'package:flutter/material.dart';
import 'package:istiqomah/models/habit.dart';
import '_header.dart';
import 'components/calendar/calendar.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    final Habit habit = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
            children: <Widget>[
              Header(habit.name),
              SizedBox(
                height: 30,
              ),
              Calendar(
                data: habit.data,
                onToggleDate: (date) {
                  print(date);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
