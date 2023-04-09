import 'package:glass_of_water/models/driver/level.dart';

class Mastery extends Level {

  Mastery(String level) : super(level) {
    windowFrameCounter = 65;
    gForceMetric = 1.0;
  }
}