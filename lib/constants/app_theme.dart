import 'package:flutter/material.dart';
import 'package:istiqomah/constants/font_family.dart';

final ThemeData themeData = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: Color(0xff2F80ED),
  colorScheme: ColorScheme.dark(
    primary: Color(0xff2F80ED),
    secondary: Colors.blueAccent,
  ),
  scaffoldBackgroundColor: Colors.blueAccent[700],
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 17),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);
