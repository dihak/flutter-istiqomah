import 'package:flutter/material.dart';
import 'package:istiqomah/constants/font_family.dart';

ThemeData darkTheme = new ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  primaryColorBrightness: Brightness.dark,
  accentColor: Colors.blueAccent[700],
  accentColorBrightness: Brightness.dark,
  backgroundColor: Colors.blueAccent[200],
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white, fontSize: 17),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);

ThemeData lightTheme = new ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
  accentColor: Colors.blueAccent,
  accentColorBrightness: Brightness.light,
  backgroundColor: Colors.blueAccent[700],
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black, fontSize: 17),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);

ThemeData blueTheme = new ThemeData(
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
