import 'package:flutter/material.dart';

Future modalEditHabit(BuildContext context, String name) async {
  final inputController = TextEditingController();

  inputController.text = name;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Ubah kebiasaan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: TextField(
              autofocus: true,
              controller: inputController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0x33FFFFFF),
                border: OutlineInputBorder(borderSide: (BorderSide.none)),
              ),
              style: TextStyle(color: Color(0xFFFFFFFF)),
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
        ],
      ),
    ),
  );
}
