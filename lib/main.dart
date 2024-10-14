import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app_theme.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/pages/home/index.dart';
import 'package:istiqomah/routes.dart';
import 'package:istiqomah/pages/get_started/index.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => habitAdapter,
      child: IstiqomahApp(),
    ),
  );
}

class IstiqomahApp extends StatefulWidget {
  @override
  IstiqomahAppState createState() => IstiqomahAppState();
}

class IstiqomahAppState extends State<IstiqomahApp> {
  Widget? _body;

  @override
  void initState() {
    super.initState();
    _loadStarted();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISTIQOMAH',
      routes: Routes.routes,
      theme: themeData,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: _body,
      ),
    );
  }

  void _loadStarted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isStarted = prefs.getBool('isStarted') == null;
    setState(() {
      _body = isStarted ? GetStarted() : Home();
    });
  }
}
