import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyTask extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You have no habit, build your habit now!',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SvgPicture.asset(
          "assets/images/empty-tasks.svg",
          semanticsLabel: 'Empty tasks',
        ),
      ],
    );
  }
}
