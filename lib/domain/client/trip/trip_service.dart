import 'dart:convert';

import 'package:glass_of_water/domain/api_base.dart';
import 'package:glass_of_water/resources/resources.dart';

class TripService extends ApiBase {
  static const _host = AppConfig.clientHost;

  Future<void> addTrip(
      int rate, int numberOfGlasses, String tripTime, String startTime) async {
    var id = await getUserId();
    final url = makeUri('$_host/user/$id/trips', null);

    final paramenters = <String, dynamic>{
      'rate': rate,
      'countOfGlasses': numberOfGlasses,
      'time': tripTime,
      'averageSpeed': 0,
      'startTime': startTime
    };

    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json');
    request.write(jsonEncode(paramenters));

    await request.close();
  }

  Future<List> getAllTrips() async {
    final id = await getUserId();

    final url = makeUri('$_host/user/$id/trips', null);

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    final response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<List> getTrip(int tripId) async {
    var id = await getUserId();
    final url = makeUri('$_host/user/$id/trips/$tripId', null);

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    final response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }
}
