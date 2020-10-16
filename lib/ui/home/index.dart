import 'package:flutter/material.dart';
import 'package:istiqomah/widgets/habits/habits.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
          children: <Widget>[
            _header(context),
            _content(),
          ],
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
            Habit.addModal(context);
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColor,
          ),
        )
      ]),
    );
  }

  Widget _content() {
    return HabitList(
      habits: [
        Habit(name: 'Sholat Shubuh di Masjid'),
        Habit(name: 'Dzikir Pagi'),
        Habit(name: 'Sholat Dhuha'),
      ],
    );
  }
}
