import 'package:flutter/material.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/models/notification.dart';
import 'package:istiqomah/pages/home/components/habit_list.dart';
import 'package:provider/provider.dart';
import 'package:istiqomah/routes.dart';
import 'modal/add.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    initializeNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 30, right: 30, left: 30),
          child: Column(
            children: <Widget>[
              _header(context),
              Expanded(child: HabitList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Expanded(
          child: Text(
            'ISTIQOMAH',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RawMaterialButton(
          fillColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(2), left: Radius.circular(10))),
          constraints: BoxConstraints.expand(width: 45, height: 45),
          onPressed: () {
            modalAddHabit(context).then(
              (value) {
                if (value == null) return;
                String name = value['name'];
                TimeOfDay time;
                List daylist;
                if (value['isReminderActive']) {
                  time = value['time'];
                  daylist = value['daylist'];
                }
                if (name != null && name != '') {
                  Provider.of<HabitModel>(context, listen: false)
                      .add(name: name, time: time, daylist: daylist);
                }
              },
            );
          },
          child: Icon(
            Icons.add,
            size: 25.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
        RawMaterialButton(
            fillColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(2), right: Radius.circular(10))),
            constraints: BoxConstraints.expand(width: 45, height: 45),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.settings);
            },
            child: Icon(
              Icons.settings,
              size: 25.0,
              color: Theme.of(context).primaryColor,
            ))
      ]),
    );
  }
}
