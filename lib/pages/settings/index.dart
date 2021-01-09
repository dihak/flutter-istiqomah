import 'package:flutter/material.dart';
import 'package:istiqomah/pages/settings/config.dart';
import 'package:istiqomah/routes.dart';
import '../../routes.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(Routes.home),
        ),
        title: Text('Setting'),
        shadowColor: Theme.of(context).canvasColor,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          elevation: 1,
          onPressed: () {
            currentTheme.switchTheme();
          },
          icon: Icon(Icons.brightness_high),
          label: Text('Theme')),
    );
  }
}
