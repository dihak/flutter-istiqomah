import 'package:flutter/material.dart';
import 'package:istiqomah/routes.dart';

class GetStarted extends StatelessWidget {
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
          padding: EdgeInsets.all(50),
          child: Column(
            children: <Widget>[
              _header(),
              Expanded(child: _content(context)),
              _button(context),
            ],
          )),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: Text(
        'ISTIQOMAH',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    List<String> lists = const [
      "Membantu kamu mencapai resolusi hidup",
      "Mengatur jenis aktivitas, dengan fitur pengingat",
      "Dapatkan rangkuman data selama perjalanan istiqomah kamu"
    ];

    List<Widget> listWidget = _createListWidget(context, lists);

    return (Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listWidget,
      ),
    ));
  }

  Widget _button(BuildContext context) {
    return FlatButton(
      minWidth: 300,
      color: Colors.white,
      textColor: Theme.of(context).primaryColor,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(20),
      splashColor: Colors.blue[50],
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      },
      child: Text(
        "Mulai",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  // Create List Widget from List<String>
  List<Widget> _createListWidget(BuildContext context, List<String> items) {
    TextStyle textStyle =
        TextStyle(fontSize: 28, color: Colors.white, height: 1.5);
    TextStyle numberStyle =
        TextStyle(fontSize: 20, color: Theme.of(context).primaryColor);
    List<Widget> result = [];

    var number = 1;
    items.forEach((text) {
      result.add(Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 20, top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(const Radius.circular(50)),
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: numberStyle,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
            ],
          )));
      number++;
    });

    return result;
  }
}
