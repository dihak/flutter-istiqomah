import 'package:flutter/material.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/models/notification.dart';
import 'package:istiqomah/pages/home/components/habit_list.dart';
import 'package:provider/provider.dart';
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
          padding: EdgeInsets.only(top: 50, right: 40, left: 40),
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
      margin: EdgeInsets.only(bottom: 20),
      child: Row(children: [
        Expanded(
          child: Text(
            'ISTIQOMAH',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RawMaterialButton(
          fillColor: Colors.white,
          shape: new CircleBorder(),
          constraints: BoxConstraints.expand(width: 50, height: 50),
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
            color: Theme.of(context).primaryColor,
          ),
        )
      ]),
    );
  }
}
