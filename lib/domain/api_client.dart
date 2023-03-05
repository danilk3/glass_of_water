import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:glass_of_water/domain/api_base.dart';
import 'package:http/http.dart' as http;

import '../data_providers/user_data_provider.dart';
import '../resources/resources.dart';

class ApiClient extends ApiBase {
  static const _host = AppConfig.clientHost;

  Future<bool> sendEmail({required String email}) async {
    final url = makeUri('$_host/auth/email', null);

    final paramenters = <String, dynamic>{
      'email': email,
    };

    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json');
    request.write(jsonEncode(paramenters));

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    return body['status'] as String == 'success';
  }

  Future<Map<String, dynamic>?> validateCode(
      {required String email, required String code}) async {
    final url = makeUri('$_host/auth/code', null);

    final paramenters = <String, dynamic>{
      'email': email,
      'code': code,
    };

    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json');
    request.write(jsonEncode(paramenters));

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    if (body['first'] as String == 'success') {
      return body['second'];
    }

    return null;
  }

  Future<void> updateRate(int newRate) async {
    var id = await getUserId();
    final url = makeUri('$_host/user/$id', null);

    final paramenters = <String, dynamic>{'rate': newRate.toString()};

    final headers = {'Content-Type': 'application/json'};

    await http.put(url, headers: headers, body: jsonEncode(paramenters));
  }

  Future<void> addTrip(int rate, int numberOfGlasses, String tripTime,
      String startTime) async {
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
    var id = await getUserId();

    final url = makeUri('$_host/user/$id/trips', null);

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<List> getTrip(int tripId) async {
    var id = await getUserId();
    final url = makeUri('$_host/user/$id/trips/$tripId', null);

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<List> getAllUsers() async {
    final url = makeUri('$_host/auth/users', null);

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<int> getUserId() async {
    var userId = int.parse(await UserDataProvider().getUserId() ?? '-1');
    return userId;
  }

  Future<void> deleteAccount() async {
    var id = await getUserId();
    final url = makeUri('$_host/user/$id', null);

    final request = await client.deleteUrl(url);
    await request.close();
  }
}
