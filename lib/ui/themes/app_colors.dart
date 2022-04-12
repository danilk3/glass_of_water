import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
abstract class AppColors {
  static const mainLightGrey = Color.fromRGBO(244, 244, 244, 1);
  static const mainLightBlue = Color.fromARGB(255, 31, 116, 207);

  static Color getProgressColor(double percent) {
    if (percent < 0.17) {
      return const Color.fromRGBO(255, 13, 13, 1);
    } else if (percent < 0.33) {
      return const Color.fromRGBO(255, 78, 17, 1);
    } else if (percent < 0.48) {
      return const Color.fromRGBO(255, 142, 21, 1);
    } else if (percent < 0.65) {
      return const Color.fromRGBO(250, 183, 51, 1);
    } else if (percent < 0.81) {
      return const Color.fromRGBO(172, 179, 52, 1);
    } else {
      return const Color.fromRGBO(105, 179, 76, 1);
    }
  }
}
