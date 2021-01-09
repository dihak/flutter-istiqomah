import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get remainder;
  String get delete;
  String get everyday;
  String get day1;
  String get day2;
  String get day3;
  String get day4;
  String get day5;
  String get day6;
  String get day7;
  String get stats;
  String get queDelete;
  String get cancel;
  String get cngHabit;
  String get habitName;
  String get ok;
  String get intro1;
  String get intro2;
  String get intro3;
  String get start;
  String get noHabit;
  String get getHabit;
  String get settingTitle;
  String get themeChange;

  //EXAMPLE IF YOU WANT TO ADD LANGUAGES

  //$Name = "Langauge" + Language initials(English = en, etc..)

  //First Day is Monday

//   import 'language.dart';

// class $Name extends Languages {
//   @override
//   String get appName => "";
//   @override
//   String get remainder => "";
//   @override
//   String get delete => "";
//   @override
//   String get everyday => "";
//   @override
//   String get day1 => "";
//   @override
//   String get day2 => "";
//   @override
//   String get day3 => "";
//   @override
//   String get day4 => "";
//   @override
//   String get day5 => "";
//   @override
//   String get day6 => "";
//   @override
//   String get day7 => "";
//   @override
//   String get stats => "";
//   @override
//   String get queDelete => "";
//   @override
//   String get cancel => "";
//   @override
//   String get cngHabit => "";
//   @override
//   String get habitName => "";
//   @override
//   String get ok => "";
//   @override
//   String get intro1 => "";
//   @override
//   String get intro2 => "";
//   @override
//   String get intro3 => "";
//   @override
//   String get start => "";
//   @override
//   String get noHabit => "";
//   @override
//   String get getHabit => "";
//   @override
//   String get settingTitle => "";
//   @override
//   String get themeChange => "";
// }

}
