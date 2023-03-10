import 'package:geolocator/geolocator.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;

class PermissionHandler {
  Future<void> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      globals.geolocationAllowed = false;
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        globals.geolocationAllowed = false;
        return;
      }
    }
    globals.geolocationAllowed = true;
  }

  void checkPermission() {
    handleLocationPermission();
  }
}
