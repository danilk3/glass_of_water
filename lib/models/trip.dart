import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trip {
  Trip({
    required this.rate,
    required this.numberOfGlasses,
    required this.tripTime,
    required this.startTime,
    required this.latlen,
  });

  final int rate;
  final int numberOfGlasses;
  final String tripTime;
  final String startTime;
  final List<LatLng?> latlen;
}
