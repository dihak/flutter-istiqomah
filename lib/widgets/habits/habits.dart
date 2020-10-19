import 'package:flutter/material.dart';
import 'package:istiqomah/widgets/habits/item/item.dart';
export 'package:istiqomah/widgets/habits/item/item.dart';
export 'package:istiqomah/widgets/habits/modal/add.dart';

class HabitList extends StatefulWidget {
  HabitList({Key key, this.children}) : super(key: key);

  final List<HabitItem> children;

  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.children,
    );
  }
}
