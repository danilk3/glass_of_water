import 'package:flutter/material.dart';
import 'package:glass_of_water/domain/client/trip/trip_service.dart';

class HistoryModel extends ChangeNotifier {
  final _tripService = TripService();

  List? _trips;

  List? get trips => _trips;

  Future<void> getTrips() async {
    _trips = await _tripService.getAllTrips();
  }
}
