import 'package:flutter/material.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:provider/provider.dart';
import '_header.dart';
import 'components/calendar/calendar.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    Habit habit = ModalRoute.of(context).settings.arguments;

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
                habit: habit,
                onToggleDate: (date) {
                  Feedback.forTap(context);
                  setState(() {
                    Provider.of<HabitModel>(context).toggleDate(habit, date);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
