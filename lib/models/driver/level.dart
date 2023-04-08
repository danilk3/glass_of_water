import 'dart:ffi';

import 'package:glass_of_water/models/driver/advantage.dart';
import 'package:glass_of_water/models/driver/beginner.dart';
import 'package:glass_of_water/models/driver/elementary.dart';
import 'package:glass_of_water/models/driver/intermediate.dart';
import 'package:glass_of_water/models/driver/level_enum.dart';
import 'package:glass_of_water/models/driver/mastery.dart';

abstract class Level {
  late LevelEnum level;
  Map<String, double> getParams();

  @override
  String toString(){
    return level.name;
  }

  static Level buildLevel(LevelEnum level) {
    switch (level) {
      case LevelEnum.beginner:
        return Beginner();
      case LevelEnum.elementary:
        return Elementary();
      case LevelEnum.intermediate:
        return Intermediate();
      case LevelEnum.advantage:
        return Advantage();
      case LevelEnum.mastery:
        return Mastery();
      default:
        return Beginner();
    }
  }
}
