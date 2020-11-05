import 'package:flutter/material.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:provider/provider.dart';
import 'item/item.dart';

class HabitList extends StatefulWidget {
  HabitList({Key key}) : super(key: key);

  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HabitModel>(
      builder: (context, data, child) => ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: data.habits.length,
        itemBuilder: (BuildContext _, int index) {
          final item = data.habits[index];
          return HabitItem(
            key: Key(item.id.toString()),
            id: item.id,
            name: item.name,
            data: item.data,
            toggleDate: (date) {
              Feedback.forTap(context);
              data.toggleDate(item, date);
            },
            onTap: () {
              Feedback.forTap(context);
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: item,
              );
            },
          );
        },
      ),
    );
  }
}
