
import 'package:flutter/material.dart';

class Routes {

  /// Pop Out View
  Future<void> popMultipleScreens(BuildContext context, int numberOfScreens) async {
    if (Navigator.canPop(context)) {
      int count = 0;
      Navigator.popUntil(context, (route) => count++ >= numberOfScreens);
    }
  }

  Future<void> pushNav(BuildContext context, {required Widget widget}) async {
    Future.delayed(Duration.zero, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => widget,
        ),
      );
    });
  }

  Future<void> pushReplacementNav(BuildContext context, {required Widget widget}) async {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => widget,
        ),
      );
    });
  }

  Future<void> pushAndRemoveUntilNav(BuildContext context, {required Widget widget}) async {
    Future.delayed(Duration.zero, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (Route<dynamic> route) => false,
      );
    });
  }

}