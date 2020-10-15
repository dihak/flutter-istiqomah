import 'package:flutter/material.dart';
import 'package:istiqomah/ui/get_started.dart';

class Routes {
  Routes._();

  //static variables
  static const String getStarted = '/getStarted';

  static final routes = <String, WidgetBuilder>{
    getStarted: (BuildContext context) => GetStarted(),
  };
}
