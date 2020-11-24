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
      builder: (context, data, child) {
        List<HabitItem> items = [];

        for (var item in data.habits) {
          items.add(HabitItem(
            key: ValueKey(item.id.toString()),
            id: item.id,
            name: item.name,
            time: item.time,
            dayList: item.daylist,
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
          ));
        }

        return ReorderableListView(
          onReorder: data.reorderHabit,
          children: items,
        );
      },
    );
  }
}
