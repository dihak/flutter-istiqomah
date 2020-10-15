import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
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
          'Get Started',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
