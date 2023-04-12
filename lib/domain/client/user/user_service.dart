import 'dart:convert';
import 'dart:io';

import 'package:glass_of_water/domain/api_base.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:http/http.dart' as http;

class UserService extends ApiBase {
  static const _host = AppConfig.clientHost;

  Future<void> updateUser(parameters) async {
    final id = await getUserId();
    final url = makeUri('$_host/user/$id', null);
    final headers = {'Content-Type': 'application/json'};
    var response =
        await http.put(url, headers: headers, body: jsonEncode(parameters));

    if (response.statusCode == 400) {
      throw Exception();
    }
  }

  Future<List> getAllUsers() async {
    final url = makeUri('$_host/auth/users', null);

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    HttpClientResponse response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<void> deleteAccount() async {
    final id = await getUserId();
    final url = makeUri('$_host/user/$id', null);

    final request = await client.deleteUrl(url);
    await request.close();
  }
}
