import 'package:glass_of_water/models/driver/level.dart';

class Intermediate extends Level {
  Map<String, double> _params = {
    "a": 1.0
  };

  @override
  Map<String, double> getParams() {
    return _params;
  }
}