import 'package:flutter/material.dart';

Future<bool> modalDeleteHabit(BuildContext context, String name) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Hapus'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Apakah anda yakin ingin menghapus $name?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Batal'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
