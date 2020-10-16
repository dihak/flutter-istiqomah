import 'package:flutter/material.dart';
import 'package:istiqomah/ui/get_started/index.dart';
import 'package:istiqomah/ui/home/index.dart';

class Routes {
  Routes._();

  //static variables
  static const String getStarted = '/getStarted';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    getStarted: (BuildContext context) => GetStarted(),
    home: (BuildContext context) => Home(),
  };
}
