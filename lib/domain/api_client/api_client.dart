import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://glass-of-water.herokuapp.com';

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

    if (body['status'] as String == 'success') {
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>?> validateCode({required String email, required String code}) async {
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

  Future<void> deleteAccount({required int id}) async {
    final url = _makeUri('/user/$id', null);

    final request = await _client.deleteUrl(url);
    await request.close();
  }

  Future<String> readResponse(HttpClientResponse response) {
    final completer = Completer<String>();
    final contents = StringBuffer();
    response.transform(utf8.decoder).listen((data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
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
