import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripDetailsModel extends ChangeNotifier {
  final Completer<GoogleMapController> _mapController = Completer();

  Completer<GoogleMapController> get mapController => _mapController;
}
