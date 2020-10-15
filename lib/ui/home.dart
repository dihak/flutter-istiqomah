import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  Widget _header(context) {
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
          onPressed: () {},
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
