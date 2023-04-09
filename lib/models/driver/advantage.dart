import 'package:glass_of_water/models/driver/level.dart';

class Advantage extends Level {
  Advantage(String level) : super(level) {
    windowFrameCounter = 60;
    gForceMetric = 1.1;
  }
}
