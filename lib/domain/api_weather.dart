import 'dart:convert';
import 'dart:io';

import 'package:glass_of_water/domain/api_base.dart';
import 'package:glass_of_water/resources/maps_utils.dart';

import '../resources/resources.dart';
import '../utils/permission_handler.dart';

class ApiWeather extends ApiBase {
  static const _host = AppConfig.weatherHost;

  Future<Map<String, dynamic>?> getWeather() async {
    final hasPermission = await PermissionHandler().handleLocationPermission();

    // TODO: если не разрешил что-то сделать

    var _currentPosition = await MapsUtils().getCurrentPosition();

    if (_currentPosition == null) {
      return null;
    }

    final uri = makeUri(
        '$_host/v1/forecast?latitude=${_currentPosition?.latitude}&longitude=${_currentPosition?.longitude}&current_weather=true',
        null);

    final request = await client.getUrl(uri);
    request.headers.set('Content-type', 'application/json');

    HttpClientResponse response = await request.close();
    final body = json.decode(await readResponse(response));
    return body;
  }
}
