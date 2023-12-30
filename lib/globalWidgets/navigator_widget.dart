import 'package:flutter/material.dart';

class NavigatorWidget {
  void screenReplacement(BuildContext context, Widget newScreen) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => newScreen,
        ));
  }

  void screenPushReplacement(BuildContext context, Widget newScreen) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => newScreen,
        ));
  }
}
