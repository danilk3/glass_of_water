import 'dart:convert';
import 'dart:io';

import 'package:glass_of_water/domain/api_base.dart';
import 'package:glass_of_water/resources/resources.dart';

class AuthService extends ApiBase {
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
}
