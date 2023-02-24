import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../resources/resources.dart';

class ApiClient {
  final _client = HttpClient();
  static const _host = AppConfig.host;

  Uri _makeUri(String path, Map<String, dynamic>? parametrs) {
    final uri = Uri.parse('$_host$path');

    if (parametrs != null) {
      return uri.replace(queryParameters: parametrs);
    } else {
      return uri;
    }
  }

  Future<bool> sendEmail({required String email}) async {
    final url = _makeUri('/auth/email', null);

    final paramenters = <String, dynamic>{
      'email': email,
    };

    final request = await _client.postUrl(url);
    request.headers.set('Content-type', 'application/json');
    request.write(jsonEncode(paramenters));

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    return body['status'] as String == 'success';
  }

  Future<Map<String, dynamic>?> validateCode(
      {required String email, required String code}) async {
    final url = _makeUri('/auth/code', null);

    final paramenters = <String, dynamic>{
      'email': email,
      'code': code,
    };

    final request = await _client.postUrl(url);
    request.headers.set('Content-type', 'application/json');
    request.write(jsonEncode(paramenters));

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    if (body['first'] as String == 'success') {
      return body['second'];
    }

    return null;
  }

  Future<void> updateRate(int id, int newRate) async {
    final url = _makeUri('/user/$id', null);

    final paramenters = <String, dynamic>{'rate': newRate.toString()};

    final headers = {'Content-Type': 'application/json'};

    await http.put(url, headers: headers, body: jsonEncode(paramenters));
  }

  Future<void> addTrip(int id, int rate, int numberOfGlasses, String tripTime,
      String startTime) async {
    final url = _makeUri('/user/$id/trips', null);

    final paramenters = <String, dynamic>{
      'rate': rate,
      'countOfGlasses': numberOfGlasses,
      'time': tripTime,
      'averageSpeed': 0,
      'startTime': startTime
    };

    final request = await _client.postUrl(url);
    request.headers.set('Content-type', 'application/json');
    request.write(jsonEncode(paramenters));

    await request.close();
  }

  Future<List> getAllTrips(int id) async {
    final url = _makeUri('/user/$id/trips', null);

    final request = await _client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<List> getTrip(int id, int tripId) async {
    final url = _makeUri('/user/$id/trips/$tripId', null);

    final request = await _client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<List> getAllUsers() async {
    final url = _makeUri('/auth/users', null);

    final request = await _client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<void> deleteAccount(int id) async {
    final url = _makeUri('/user/$id', null);

    final request = await _client.deleteUrl(url);
    await request.close();
  }

  Future<String> readResponse(HttpClientResponse response) {
    final completer = Completer<String>();
    final contents = StringBuffer();
    response.transform(utf8.decoder).listen(contents.write,
        onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
