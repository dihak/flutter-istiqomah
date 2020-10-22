import 'package:flutter/material.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/ui/detail/_date.dart';
import 'package:istiqomah/ui/detail/_header.dart';

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
                height: 20,
              ),
              Date(),
            ],
          ),
        ),
      ),
    );
  }
}
