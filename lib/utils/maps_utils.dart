import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'permission_handler.dart';

class MapsUtils {
  Future<Position> getCurrentPosition() async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
