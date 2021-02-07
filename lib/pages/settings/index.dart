import 'package:flutter/material.dart';
import 'package:istiqomah/constants/app_theme.dart';
import 'package:istiqomah/routes.dart';
import 'package:provider/provider.dart';
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
          color: Theme.of(context).buttonColor,
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(Routes.home),
        ),
        title: Text('Settings'),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
            ),
        shadowColor: Theme.of(context).canvasColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile(
                title: Text(
                  "Dark Mode",
                  style: TextStyle(color: Colors.white),
                ),
                activeColor: Theme.of(context).accentColor,
                inactiveThumbColor: Colors.blueGrey,
                inactiveTrackColor: Colors.grey,
                inactiveThumbImage:
                    new AssetImage('assets/images/light-mode.png'),
                activeThumbImage:
                    new AssetImage('assets/images/night-mode.png'),
                onChanged: (val) {
                  notifier.toggleTheme();
                },
                value: notifier.darkTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
