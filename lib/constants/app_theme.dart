import 'package:flutter/material.dart';
import 'package:istiqomah/constants/font_family.dart';

final ThemeData themeData = new ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: Color(0xff2F80ED),
  primaryColorBrightness: Brightness.dark,
  accentColor: Colors.blueAccent,
  accentColorBrightness: Brightness.dark,
  backgroundColor: Colors.blueAccent[700],
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white, fontSize: 17),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);
