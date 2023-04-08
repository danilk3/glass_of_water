import 'package:glass_of_water/models/driver/level.dart';
import 'package:glass_of_water/models/driver/level_enum.dart';

class Beginner extends Level {

  Map<String, double> _params = {
    "a": 1.0
  };

  Beginner(){
    level = LevelEnum.beginner;
  }

  @override
  Map<String, double> getParams() {
    return _params;
  }
}
