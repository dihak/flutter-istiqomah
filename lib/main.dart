import 'package:flutter/material.dart';
import 'package:istiqomah/routes.dart';
import 'package:istiqomah/ui/get_started.dart';

void main() => runApp(IstiqomahApp());

class IstiqomahApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISTIQOMAH',
      routes: Routes.routes,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: GetStarted(),
      ),
    );
  }
}
