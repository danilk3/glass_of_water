import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glass_of_water/models/driver/level.dart';
import 'package:glass_of_water/navigation/main_navigation.dart';
import 'package:glass_of_water/utils/maps_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:sensors_plus/sensors_plus.dart';

class TripModel extends ChangeNotifier {
  late Level _level;

  late double? _gammaAngle;
  late double? _thetaAngle;
  double _phiAngle = 0;
  late Matrix? _rotationMatrix;
  bool _shouldSpill = false;

  bool get shouldSpill => _shouldSpill;
  Vector? _previousWindow;
  bool _isTripStarted = false;

  bool get isTripStarted => _isTripStarted;
  int _numberOfSpills = 0;

  int get numberOfSpills => _numberOfSpills;
  final _stopwatch = Stopwatch();

  Timer? _mapTimer;
  final List<LatLng> _latLen = [];

  var _x = 0.0;
  var _y = 0.0;
  var _z = 0.0;

  var _stableX = 0.0;
  var _stableY = 0.0;

  void startTrip() {
    _init();
    _initListen();
  }

  void _init() {
    _mapTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final position = await MapsUtils().getCurrentPosition();
      _latLen.add(LatLng(position.latitude, position.longitude));
    });

    // _level = await

    _stopwatch.start();
    _numberOfSpills = 0;
    _isTripStarted = true;
    notifyListeners();
  }

  void _initListen() {
    var _windowCounter = 0;

    final subscription = accelerometerEvents.listen(null);
    subscription.onData((event) async {
      ++_windowCounter;
      if (_windowCounter == 10) {
        _setStableMetrics();
      } else if (_windowCounter % 10 == 0) {
        _setMedianMetrics();
        _increasePhiAngle();
        _toNullMetrics();
      } else if (_windowCounter < 100) {
        _increaseMetrics(event);
      } else {
        _phiAngle /= 9;
        _calculateRotationMatrix();
        await subscription.cancel();
        _listenMovements();
      }
    });
  }

  void _increaseMetrics(AccelerometerEvent event) {
    _x += event.x;
    _y += event.y;
    _z += event.z;
  }

  void _setStableMetrics() {
    _setMedianMetrics();
    _countThetaAngle();
    _countGammaAngle();

    _stableX = _x;
    _stableY = _y;

    _toNullMetrics();
  }

  void _toNullMetrics() {
    _x = 0;
    _y = 0;
    _z = 0;
  }

  void _setMedianMetrics() {
    _x /= 10;
    _y /= 10;
    _z /= 10;
  }

  void _countThetaAngle() {
    _thetaAngle = asin(_y / 9.8);
  }

  void _countGammaAngle() {
    _gammaAngle = atan(-_x / _z);
  }

  void _increasePhiAngle() {
    final _xStableDiff = _x - _stableX;
    final _yStableDiff = _y - _stableY;
    final _angleTanSinComposition = tan(_thetaAngle!) * sin(_gammaAngle!);
    final _angleCosRelation = cos(_thetaAngle!) / cos(_gammaAngle!);
    _phiAngle += atan(
      (_xStableDiff / _yStableDiff - _angleTanSinComposition) *
          _angleCosRelation,
    );
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
    var _windowCounter = 0;
    double x;
    double y;
    double z;
    x = y = z = 0;
    var matrixCounter = 0;
    final subscription = accelerometerEvents.listen(null);
    subscription.onData((event) async {
      if (!_isTripStarted) {
        await subscription.cancel();
      }

      ++_windowCounter;
      if (_windowCounter == 55) {
        ++matrixCounter;
        final currentWindow =
            Vector.fromList([x / 55, y / 55, z / 55]) * _rotationMatrix!;
        x = y = z = 0;
        _windowCounter = 0;

        _previousWindow ??= currentWindow;

        if ((currentWindow[0] - _previousWindow![0]).abs() >= 1.2) {
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
          await subscription.cancel();
          _initListen();
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
    _stopwatch
      ..stop()
      ..reset();
    _mapTimer?.cancel();
    _isTripStarted = false;
    notifyListeners();
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.tripResults,
      arguments: [
        _numberOfSpills,
        elapsedMilliseconds,
        _latLen,
      ],
    );
  }
}
