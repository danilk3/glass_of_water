import 'package:glass_of_water/models/driver/level.dart';

class Beginner extends Level {

  Beginner(String level) : super(level) {
    windowFrameCounter = 45;
    gForceMetric = 1.4;
  }
}
