import 'package:flutter/material.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/pages/detail/modal/delete.dart';
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
              Header(habit.name, onChange: (name) {
                setState(() {
                  habit.name = name;
                  Provider.of<HabitModel>(context, listen: false).update(habit);
                });
              }),
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
              FlatButton.icon(
                onPressed: () {
                  modalDeleteHabit(context, habit.name).then((value) {
                    if (value) {
                      Navigator.pop(context);
                      setState(() {
                        Provider.of<HabitModel>(context).remove(habit);
                      });
                    }
                  });
                },
                padding: EdgeInsets.all(10),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: Text(
                  'Hapus',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
