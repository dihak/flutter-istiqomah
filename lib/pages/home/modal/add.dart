import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app.dart';

class _ModalAddHabit extends StatefulWidget {
  @override
  _ModalAddHabitState createState() => _ModalAddHabitState();
}

class _ModalAddHabitState extends State<_ModalAddHabit> {
  final inputController = TextEditingController();

  bool isReminderActive = false;
  TimeOfDay selectedTime = TimeOfDay(hour: 07, minute: 00);
  List<int> activeDay = [1, 2, 3, 4, 5, 6, 7];

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Get into a Habit',
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
          isReminderActive = !isReminderActive;
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

    if (isReminderActive) {
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

  Widget _dayItem({String text, bool active, Function onTap}) {
    BoxDecoration decorationActive =
        BoxDecoration(color: Colors.white, shape: BoxShape.circle);

    BoxDecoration decorationInactive =
        BoxDecoration(color: Colors.white10, shape: BoxShape.circle);
    return GestureDetector(
        onTap: () => onTap(text),
        child: Container(
          decoration: active ? decorationActive : decorationInactive,
          width: 35,
          height: 35,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: active ? Colors.blue : Colors.white70,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ),
        ));
  }

  String getTime(TimeOfDay time) {
    final period = time.hour >= 12 ? 'PM' : 'AM';
    final hour = selectedTime.hourOfPeriod
        .toString()
        .padLeft(2, '0')
        .replaceAll('00', '12');
    final minute = selectedTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }

  Widget _timePicker(BuildContext context) {
    return Center(
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        color: Colors.white10,
        onPressed: () {
          showTimePicker(context: context, initialTime: selectedTime).then(
            (value) {
              if (value == null) return;
              setState(() {
                selectedTime = value;
              });
            },
          );
        },
        child: Text(
          getTime(selectedTime),
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
            child: FlatButton(
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
            child: FlatButton(
              color: Theme.of(context).accentColor,
              textColor: Theme.of(context).primaryColor,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              splashColor: Colors.blue[50],
              onPressed: () {
                Navigator.pop(context, {
                  'name': inputController.text,
                  'isReminderActive': isReminderActive,
                  'time': activeDay.length != 0 ? selectedTime : null,
                  'daylist': activeDay
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
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

Future<Map> modalAddHabit(BuildContext context) async {
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
      child: _ModalAddHabit(),
    ),
  );
}
