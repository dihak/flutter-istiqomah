import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app.dart';
import 'package:istiqomah/constants/app_theme.dart';
import 'package:istiqomah/models/habit.dart';

class _ModalEditHabit extends StatefulWidget {
  _ModalEditHabit(this.habit);

  final Habit habit;

  @override
  _ModalEditHabitState createState() => _ModalEditHabitState(habit);
}

class _ModalEditHabitState extends State<_ModalEditHabit> {
  final inputController = TextEditingController();

  bool? isReminderActive = false;
  TimeOfDay? selectedTime = TimeOfDay(hour: 07, minute: 00);
  List<int> activeDay = [1, 2, 3, 4, 5, 6, 7];

  _ModalEditHabitState(Habit habit) {
    inputController.text = habit.name!;
    inputController.selection = TextSelection.fromPosition(
        TextPosition(offset: inputController.text.length));
    isReminderActive = habit.time != null;
    if (habit.time != null) {
      selectedTime = habit.time;
      activeDay = [...habit.daylist!];
    }
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Change Habits',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _inputName(),
        _reminder(context),
        _actionButton(context),
      ],
    );
  }

  Widget _reminder(BuildContext context) {
    Widget toggleButton = GestureDetector(
      onTap: () {
        setState(() {
          isReminderActive = !isReminderActive!;
        });
      },
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Checkbox(
              onChanged: (value) {
                setState(() {
                  isReminderActive = value;
                });
              },
              value: isReminderActive,
              activeColor: Colors.blue[700],
              checkColor: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: Text(
            'Reminder',
            style: TextStyle(fontSize: 15),
          )),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );

    Widget dateList = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var item in dayShortName)
          _dayItem(
            text: item,
            active: activeDay.indexOf(dayShortName.indexOf(item) + 1) != -1,
            onTap: (value) {
              int week = dayShortName.indexOf(value) + 1;
              setState(() {
                if (activeDay.indexOf(week) == -1) {
                  activeDay.add(week);
                } else {
                  activeDay.remove(week);
                }
              });
            },
          ),
      ],
    );

    List<Widget> childrenList = [toggleButton];

    if (isReminderActive!) {
      childrenList.add(_timePicker(context));
      childrenList.add(SizedBox(height: 10));
      childrenList.add(dateList);
      childrenList.add(SizedBox(height: 20));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: childrenList,
    );
  }

  Widget _dayItem({required String text, required bool active, Function? onTap}) {
    BoxDecoration decorationActive =
        BoxDecoration(color: Colors.white10, shape: BoxShape.circle);

    BoxDecoration decorationInactive =
        BoxDecoration(shape: BoxShape.circle);
    return GestureDetector(
        onTap: () => onTap!(text),
        child: Container(
          decoration: active ? decorationActive : decorationInactive,
          width: 35,
          height: 35,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: active ? Colors.white : Colors.white70,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ),
        ));
  }

  String getTime(TimeOfDay time) {
    final period = time.hour >= 12 ? 'PM' : 'AM';
    final hour = selectedTime!.hourOfPeriod
        .toString()
        .padLeft(2, '0')
        .replaceAll('00', '12');
    final minute = selectedTime!.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }

  Widget _timePicker(BuildContext context) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          backgroundColor: Colors.white10,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          showTimePicker(
            context: context,
            initialTime: selectedTime!,
          ).then(
            (value) {
              if (value == null) return;
              setState(() {
                selectedTime = value;
              });
            },
          );
        },
        child: Text(
          getTime(selectedTime!),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _inputName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            'Name',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        TextField(
          autofocus: true,
          controller: inputController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0x33FFFFFF),
            border: OutlineInputBorder(borderSide: (BorderSide.none)),
            contentPadding: EdgeInsets.all(10),
          ),
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
      ],
    );
  }

  Widget _actionButton(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Center(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColor,
                disabledBackgroundColor: Colors.grey,
                disabledForegroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () {
                Habit habit = widget.habit;
                habit.name = inputController.text;
                if (isReminderActive! && activeDay.length != 0) {
                  habit.time = selectedTime;
                  habit.setDayList(activeDay);
                } else {
                  habit.time = null;
                  habit.daylist = null;
                }
                Navigator.pop(context, habit);
              },
              child: Text(
                "OK",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<Habit?> modalEditHabit(BuildContext context, Habit habit) async {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
    ),
    backgroundColor: Theme.of(context).primaryColor,
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(30),
      child: _ModalEditHabit(habit),
    ),
  );
}
