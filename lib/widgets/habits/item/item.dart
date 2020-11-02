import 'package:flutter/material.dart';
import 'package:istiqomah/widgets/habits/item/date.dart';

const TextStyle title = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

class HabitItem extends StatefulWidget {
  HabitItem({
    Key key,
    this.id,
    this.name,
    this.data,
    this.toggleDate,
    this.onTap,
  });

  final int id;
  final String name;
  final List data;
  final Function toggleDate;
  final Function onTap;

  _HabitItemState createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Color(0xff559DFF),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _checklist(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Text(
        widget.name,
        style: title,
      ),
    );
  }

  Widget _checklist() {
    final List<HabitDate> dateList = [];
    final DateTime currentDate = new DateTime.now();

    for (var i = 5; i >= 0; i--) {
      var date = currentDate.subtract(Duration(days: i));
      var dateString = date.toString().substring(0, 10);
      dateList.add(
        HabitDate(
          date: dateString,
          isChecked: widget.data?.indexOf(i) != -1,
          onChange: () => widget.toggleDate(i),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dateList,
    );
  }
}
