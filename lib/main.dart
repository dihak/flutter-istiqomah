import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app_theme.dart';
import 'package:istiqomah/models/habit.dart';
import 'package:istiqomah/pages/home/index.dart';
import 'package:istiqomah/pages/settings/config.dart';
import 'package:istiqomah/routes.dart';
import 'package:istiqomah/pages/get_started/index.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/app_theme.dart';

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
  _IstiqomahAppState createState() => _IstiqomahAppState();
}

class _IstiqomahAppState extends State<IstiqomahApp> {
  Widget _body;

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
    _loadStarted();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISTIQOMAH',
      routes: Routes.routes,
      theme: blueTheme,
      darkTheme: darkTheme,
      themeMode: currentTheme.currentTheme(),
      home: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
