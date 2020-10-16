import 'package:flutter/material.dart';

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
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
          child: Column(
            children: <Widget>[
              _header(context),
              Expanded(child: _content()),
            ],
          )),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(children: [
        Expanded(
            child: Text(
          'ISTIQOMAH',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )),
        RawMaterialButton(
          fillColor: Colors.white,
          shape: new CircleBorder(),
          constraints: BoxConstraints.expand(width: 50, height: 50),
          onPressed: () {
            _addHabit(context);
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
    return SafeArea(
      child: Center(
        child: Text('Content'),
      ),
    );
  }
}

void _addHabit(context) {
  showModalBottomSheet(
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
              'Tambah kebiasaan',
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
                onPressed: () {},
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
