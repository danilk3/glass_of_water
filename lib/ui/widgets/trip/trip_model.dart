import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glass_of_water/domain/weather/api_weather.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../navigation/main_navigation.dart';
import '../../../utils/maps_utils.dart';

class TripModel extends ChangeNotifier {
  ApiWeather _apiWeather = ApiWeather();

  double? _gammaAngle;
  double? _thetaAngle;
  double _phiAngle = 0;
  Matrix? _rotationMatrix;
  bool _shouldSpill = false;

  bool get shouldSpill => _shouldSpill;
  Vector? _previousWindow;
  bool _isTripStarted = false;

  bool get isTripStarted => _isTripStarted;
  int _numberOfSpills = 0;

  int get numberOfSpills => _numberOfSpills;
  final _stopwatch = Stopwatch();

  Timer? _mapTimer;
  List<LatLng> _latLen = [];



  void startTrip() {
    int _windowCounter = 0;

    _mapTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      // TODO: нужно ли добавлять разрешение пользователя?
      var position = await MapsUtils().getCurrentPosition();
      _latLen.add(LatLng(position.latitude, position.longitude));
    });

    _stopwatch.start();
    _numberOfSpills = 0;
    _isTripStarted = true;
    notifyListeners();
    double x, y, z, x1, y1, z1;
    x = y = z = x1 = y1 = z1 = 0;
    var subscription = accelerometerEvents.listen(null);
    subscription.onData((event) async {
      ++_windowCounter;

      if (_windowCounter < 10) {
        x += event.x;
        y += event.y;
        z += event.z;
      } else if (_windowCounter == 10) {
        x1 = x / 10;
        y1 = y / 10;
        z1 = z / 10;

        _thetaAngle = asin(y1 / 9.8);
        _gammaAngle = atan(-x1 / z1);
        x = y = z = 0;
      } else if (_windowCounter == 101) {
        _phiAngle /= 9;
        _windowCounter = 0;
        _calculateRotationMatrix();
        _listenMovements();
        subscription.cancel();
      } else if (_windowCounter % 10 == 0) {
        _phiAngle += atan(((((x / 10) - x1) / ((y / 10) - y1)) -
                tan(_thetaAngle!) * sin(_gammaAngle!)) *
            (cos(_thetaAngle!) / cos(_gammaAngle!)));
        x = y = z = 0;
      } else {
        x += event.x;
        y += event.y;
        z += event.z;
      }
    });
  }

  void _calculateRotationMatrix() {
    final firstMatrix = Matrix.fromList([
      [cos(_gammaAngle!), 0, -sin(_gammaAngle!)],
      [0, 1, 0],
      [sin(_gammaAngle!), 0, cos(_gammaAngle!)]
    ]);
    final secondMatrix = Matrix.fromList([
      [1, 0, 0],
      [0, cos(_thetaAngle!), sin(_thetaAngle!)],
      [0, -sin(_thetaAngle!), cos(_thetaAngle!)]
    ]);
    final thirdMatrix = Matrix.fromList([
      [cos(_phiAngle), sin(_phiAngle), 0],
      [-sin(_phiAngle), cos(_phiAngle), 0],
      [0, 0, 1]
    ]);
    _rotationMatrix = firstMatrix * secondMatrix * thirdMatrix;
  }

  void _listenMovements() {
    int _windowCounter = 0;
    double x, y, z;
    x = y = z = 0;
    int matrixCounter = 0;
    var subscription = accelerometerEvents.listen(null);
    // ignore: cascade_invocations
    subscription.onData((event) async {
      if (!_isTripStarted) {
        subscription.cancel();
      }

      ++_windowCounter;
      if (_windowCounter == 10) {
        ++matrixCounter;
        var currentWindow =
            Vector.fromList([x / 10, y / 10, z / 10]) * _rotationMatrix!;
        x = y = z = 0;
        _windowCounter = 0;

        if (_previousWindow == null) {
          _previousWindow = currentWindow;
        }

        if ((currentWindow[0] - _previousWindow![1]).abs() >= 0.8) {
          ++_numberOfSpills;
          _shouldSpill = true;
          notifyListeners();
          await Future.delayed(const Duration(seconds: 1));
          _shouldSpill = false;
          notifyListeners();
        } else if ((currentWindow[0] - _previousWindow![0]).abs() >= 1.2) {
          ++_numberOfSpills;
          _shouldSpill = true;
          notifyListeners();
          await Future.delayed(const Duration(seconds: 1));
          _shouldSpill = false;
          notifyListeners();
        }
        _previousWindow = currentWindow;
        if (matrixCounter == 1000) {
          matrixCounter = 0;
          startTrip();
        }
      } else {
        x += event.x;
        y += event.y;
        z += event.z;
      }
    });
  }

  void endTrip(BuildContext context) {
    final elapsedMilliseconds = _stopwatch.elapsedMilliseconds;
    _stopwatch.stop();
    _stopwatch.reset();
    _mapTimer?.cancel();
    _isTripStarted = false;
    notifyListeners();
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.tripResults, arguments: [
      _numberOfSpills,
      elapsedMilliseconds,
      _latLen,
    ]);
  }

  Future<void> getCoordinates() async {
    var body = await _apiWeather.getWeather();
  }
}
