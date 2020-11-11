import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app.dart';

class _ModalAddHabit extends StatefulWidget {
  @override
  _ModalAddHabitState createState() => _ModalAddHabitState();
}

class _ModalAddHabitState extends State<_ModalAddHabit> {
  final inputController = TextEditingController();

  bool isReminderActive = false;

  List<String> activeDay = [];

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Tambah kebiasaan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _inputName(),
        _reminder(),
        _actionButton(context),
      ],
    );
  }

  Widget _reminder() {
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
          Expanded(child: Text('Pengingat')),
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
            active: activeDay.indexOf(item) != -1,
            onTap: (value) {
              setState(() {
                if (activeDay.indexOf(value) == -1) {
                  activeDay.add(value);
                } else {
                  activeDay.remove(value);
                }
              });
            },
          ),
      ],
    );

    List<Widget> childrenList = [toggleButton];

    if (isReminderActive) {
      childrenList.add(_timePicker());
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
          width: 45,
          height: 45,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: active ? Colors.blue : Colors.white70,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ));
  }

  Widget _timePicker() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '12:00 AM',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
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
            'Nama',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        TextField(
          autofocus: true,
          controller: inputController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0x33FFFFFF),
            border: OutlineInputBorder(borderSide: (BorderSide.none)),
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
                'Batal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
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
              color: Colors.white,
              textColor: Theme.of(context).primaryColor,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              splashColor: Colors.blue[50],
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              onPressed: () {
                Navigator.pop(context, inputController.text);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                "OK",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<String> modalAddHabit(BuildContext context) async {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(40.0),
      ),
    ),
    backgroundColor: Theme.of(context).primaryColor,
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(40),
      child: _ModalAddHabit(),
    ),
  );
}
