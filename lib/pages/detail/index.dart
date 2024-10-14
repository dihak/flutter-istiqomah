import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/pages/detail/components/chart/monthly_chart.dart';
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
    Habit habit = ModalRoute.of(context)!.settings.arguments as Habit;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              _header(context, habit),
              SizedBox(height: 20),
              if (habit.time != null) _alarm(habit),
              SizedBox(height: 15),
              _calendar(context, habit),
              _chart(context, habit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, Habit habit) {
    return Header(habit,
        onChange: (habit) {
          Provider.of<HabitModel>(context, listen: false).update(habit);
        },
        onRemove: (Habit habit) =>
            Provider.of<HabitModel>(context, listen: false).remove(habit));
  }

  Widget _alarm(Habit habit) {
    List<String> dayString =
        habit.daylist!.map((e) => dayShortName[e - 1]).toList();

    return Row(
      children: [
        Icon(
          Icons.alarm,
          size: 14,
        ),
        SizedBox(width: 5),
        Text(
          MaterialLocalizations.of(context)
              .formatTimeOfDay(habit.time!, alwaysUse24HourFormat: false),
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.replay,
          size: 14,
        ),
        SizedBox(width: 5),
        Text(
          dayString.length == 7 ? 'Everyday' : dayString.join(', '),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _calendar(BuildContext context, Habit habit) {
    return Consumer<HabitModel>(
      builder: (context, habitModel, child) {
        return Calendar(
          habit: habit,
          onToggleDate: (date) {
            Feedback.forTap(context);
            habitModel.toggleDate(habit, date);
          },
        );
      },
    );
  }

  Widget _chart(BuildContext context, Habit habit) {
    return Consumer<HabitModel>(
      builder: (context, habitModel, child) {
        return Container(
          child: MonthlyChart(habit),
          height: 350,
        );
      },
    );
  }
}
