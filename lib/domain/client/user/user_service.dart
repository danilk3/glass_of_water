import 'dart:convert';
import 'dart:io';

import 'package:glass_of_water/domain/api_base.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:http/http.dart' as http;

class UserService extends ApiBase {
  static const _host = AppConfig.clientHost;

  Future<void> updateRate(int newRate) async {
    var id = await getUserId();
    final url = makeUri('$_host/user/$id', null);

    final paramenters = <String, dynamic>{'rate': newRate.toString()};

    final headers = {'Content-Type': 'application/json'};

    await http.put(url, headers: headers, body: jsonEncode(paramenters));
  }

  Future<void> updateLevel() async {
    var id = await getUserId();
    final url = makeUri('$_host/user/$id', null);

    var level = await getUserLevel();
    final paramenters = <String, dynamic>{'level': level};

    final headers = {'Content-Type': 'application/json'};

    await http.put(url, headers: headers, body: jsonEncode(paramenters));
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
    var id = await getUserId();
    final url = makeUri('$_host/user/$id', null);

    final request = await client.deleteUrl(url);
    await request.close();
  }
}
