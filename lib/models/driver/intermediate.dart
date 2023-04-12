import 'package:glass_of_water/models/driver/level.dart';

class Intermediate extends Level {


  Intermediate(String level) : super(level){
    windowFrameCounter = 55;
    gForceMetric = 1.2;
  }
}