import 'package:flutter/material.dart';
import 'package:istiqomah/pages/detail/index.dart';
import 'package:istiqomah/pages/get_started/index.dart';
import 'package:istiqomah/pages/home/index.dart';
import 'package:istiqomah/pages/settings/index.dart';

class Routes {
  Routes._();

  //static variables
  static const String getStarted = '/getStarted';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String detail = '/detail';

  static final routes = <String, WidgetBuilder>{
    getStarted: (BuildContext context) => GetStarted(),
    home: (BuildContext context) => Home(),
    settings: (BuildContext context) => Settings(),
    detail: (BuildContext context) => Detail(),
  };
}
