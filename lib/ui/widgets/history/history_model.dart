import 'package:flutter/material.dart';
import 'package:glass_of_water/domain/client/trip/trip_service.dart';
import 'package:glass_of_water/models/trip.dart';
import 'package:glass_of_water/navigation/main_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryModel extends ChangeNotifier {
  final _tripService = TripService();

  List? _trips;

  List? get trips => _trips;

  Future<void> getTrips() async {
    _trips = await _tripService.getAllTrips();
  }

  void goToDetails(BuildContext context, _trip) {
    var latlen = _trip['latlen'];

    final latLen = latlen.map(LatLng.fromJson).toList();

    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.tripDetails,
      arguments: Trip(
        rate: _trip['rate'],
        numberOfGlasses: _trip['countOfGlasses'],
        tripTime: _trip['time'],
        startTime: _trip['startTime'],
        latlen: (latLen as List).map((item) => item as LatLng?).toList(),
      ),
    );
  }
}
