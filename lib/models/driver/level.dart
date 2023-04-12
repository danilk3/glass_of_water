import 'package:glass_of_water/models/driver/advantage.dart';
import 'package:glass_of_water/models/driver/beginner.dart';
import 'package:glass_of_water/models/driver/elementary.dart';
import 'package:glass_of_water/models/driver/intermediate.dart';
import 'package:glass_of_water/models/driver/mastery.dart';

abstract class Level {
  Level(this.level);

  late String level;
  late final int windowFrameCounter;
  late final double gForceMetric;

  @override
  String toString(){
    return level;
  }

  static Level buildLevel(String? level) {
    switch (level) {
      case 'beginner':
        return Beginner('beginner');
      case 'elementary':
        return Elementary('elementary');
      case 'intermediate':
        return Intermediate('intermediate');
      case 'advantage':
        return Advantage('advantage');
      case 'mastery':
        return Mastery('mastery');
      default:
        return Beginner('beginner');
    }
  }
}
