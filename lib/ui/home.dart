import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: Text(
          'Homepage',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
