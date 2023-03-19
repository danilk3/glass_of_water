import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data_providers/user_data_provider.dart';
import '../../../domain/api_client.dart';

class TripResultsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final Completer<GoogleMapController> _mapController = Completer();

  Completer<GoogleMapController> get mapController => _mapController;

  double _percentRate = 0;

  double get percentRate => _percentRate;

  late int _numberOfSpills;

  int get numberOfSpills => _numberOfSpills;

  late String _time;

  String get time => _time;

  void initModel(int elapsedMilliseconds, int numberOfSpills) {
    final hours = elapsedMilliseconds ~/ 3600000;
    final minutes = (elapsedMilliseconds ~/ 60000) % 60;
    final seconds = (elapsedMilliseconds ~/ 1000) % 60;

    final _hoursString = hours < 10 ? '0$hours' : '$hours';
    final _minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    final _secondsString = seconds < 10 ? '0$seconds' : '$seconds';

    _time = '$_hoursString:$_minutesString:$_secondsString';

    _percentRate =
        (1 - (numberOfSpills - hours * 2 - minutes ~/ 30) / 100) * 1.0;

    _numberOfSpills = numberOfSpills;

    final totalMinutes = hours * 60.0 + minutes + seconds / 60.0 + 0.01;
    _percentRate = _countRate(numberOfSpills, totalMinutes);

    sendTrip();
    updateRate();
  }

  double _countRate(int numberOfSpills, double totalMinutes) {
    if (numberOfSpills == 0) {
      return 1;
    } else if (numberOfSpills == totalMinutes) {
      return 0.5;
    } else if (totalMinutes < 1) {
      return totalMinutes / numberOfSpills;
    } else {
      return totalMinutes / (numberOfSpills + totalMinutes);
    }
  }

  Future<void> updateRate() async {
    if (!globals.isAuth) {
      return;
    }
    final rate = int.parse(await UserDataProvider().getUserRate() ?? '0');

    final countOfTrips = (await _apiClient.getAllTrips()).length;

    final newRate = (rate + _percentRate * 100) ~/ (countOfTrips + 1);

    await _apiClient.updateRate(newRate);

    if (rate == 0) {
      await UserDataProvider()
          .setUserRate((_percentRate * 100.0).toInt().toString());
    } else {
      await UserDataProvider().setUserRate(newRate.toString());
    }
  }

  Future<void> sendTrip() async {
    if (!globals.isAuth) {
      return;
    }
    final now = DateTime.now();
    final convertedDateTime =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    await _apiClient.addTrip(
      (_percentRate * 100.0).toInt(),
      _numberOfSpills,
      _time,
      convertedDateTime,
    );
  }
}
