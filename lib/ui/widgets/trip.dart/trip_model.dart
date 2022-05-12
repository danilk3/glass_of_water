import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:sensors_plus/sensors_plus.dart';

class TripModel extends ChangeNotifier {
  int _windowCounter = 0;
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

  Future<void> startTrip() async {
    _stopwatch.start();
    _numberOfSpills = 0;
    _isTripStarted = true;
    notifyListeners();
    print('TRIP STARTED');
    double x, y, z, x1, y1, z1;
    x = y = z = x1 = y1 = z1 = 0;
    var subscription = accelerometerEvents.listen(null);
    subscription.onData((event) {
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

        print(_thetaAngle);
        print(_gammaAngle);
      } else if (_windowCounter == 101) {
        _phiAngle /= 9;
        _windowCounter = 0;
        _calculateRotationMatrix();
        _listenMovements();
        subscription.cancel();
      } else if (_windowCounter % 10 == 0) {
        _phiAngle += atan(
            ((((x / 10) - x1) / ((y / 10) - y1)) - tan(_thetaAngle!) * sin(_gammaAngle!)) *
                (cos(_thetaAngle!) / cos(_gammaAngle!)));
        x = y = z = 0;
      } else {
        x += event.x;
        y += event.y;
        z += event.z;
      }
    });
  }

  Future<void> _calculateRotationMatrix() async {
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

    print(_rotationMatrix);
  }

  Future<void> _listenMovements() async {
    double x, y, z;
    x = y = z = 0;
    var subscription = accelerometerEvents.listen(null);
    // ignore: cascade_invocations
    subscription.onData((event) async {

      if (!_isTripStarted) {
        subscription.cancel();
      }

      ++_windowCounter;
      if (_windowCounter == 10) {
        var currentWindow = Vector.fromList([x / 10, y / 10, z / 10]) * _rotationMatrix!;
        print(currentWindow);
        x = y = z = 0;
        _windowCounter = 0;

        if (_previousWindow == null) {
          _previousWindow = currentWindow;
        }

        if ((currentWindow[0] - _previousWindow![1]).abs() >= 0.8) {
          ++_numberOfSpills;
          _shouldSpill = true;
          notifyListeners();
          await Future.delayed(const Duration(seconds: 4));
          _shouldSpill = false;
          notifyListeners();
        } else if ((currentWindow[0] - _previousWindow![0]).abs() >= 1.2) {
          ++_numberOfSpills;
          _shouldSpill = true;
          notifyListeners();
          await Future.delayed(const Duration(seconds: 4));
          _shouldSpill = false;
          notifyListeners();
        }

        // else if(false /*w(k) - w(s)*/) {
        //   // всплеск
        // }

        _previousWindow = currentWindow;
      } else {
        x += event.x;
        y += event.y;
        z += event.z;
      }
    });
  }

  Future<void> endTrip(BuildContext context) async {
    final elapsedMilliseconds = _stopwatch.elapsedMilliseconds;
    _stopwatch.stop();
    _stopwatch.reset();
    print('TRIP ENDED');
    _isTripStarted = false;
    notifyListeners();
    await Navigator.of(context).pushNamed(MainNavigationRouteNames.tripResults, arguments: [_numberOfSpills, elapsedMilliseconds]);
  }
}
