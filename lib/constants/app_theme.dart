import 'package:flutter/material.dart';
import 'package:istiqomah/constants/font_family.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData dark = new ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: Color(0xff101010),
  primaryColorBrightness: Brightness.dark,
  accentColor: Color(0xff4a73c2),
  accentColorBrightness: Brightness.dark,
  backgroundColor: Color(0xff5f9cd9),
  buttonColor: Color(0xff5f9cd9),
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white, fontSize: 17),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);

ThemeData light = new ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.light,
  primaryColor: Color(0xff2F80ED),
  primaryColorBrightness: Brightness.light,
  accentColor: Colors.blueAccent,
  accentColorBrightness: Brightness.light,
  backgroundColor: Colors.blueAccent[700],
  buttonColor: Colors.white,
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white, fontSize: 17),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}
