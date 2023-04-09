import 'package:glass_of_water/models/driver/level.dart';

class Elementary extends Level {

  Elementary(String level) : super(level){
    windowFrameCounter = 50;
    gForceMetric = 1.3;
  }
}