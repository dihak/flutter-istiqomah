import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app_theme.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/routes.dart';
import 'package:istiqomah/pages/get_started/index.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => HabitModel(),
        child: IstiqomahApp(),
      ),
    );

class IstiqomahApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISTIQOMAH',
      routes: Routes.routes,
      theme: themeData,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: GetStarted(),
      ),
    );
  }
}
