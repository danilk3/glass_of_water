import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ApiBase {
  final client = HttpClient();

  Future<String> readResponse(HttpClientResponse response) {
    final completer = Completer<String>();
    final contents = StringBuffer();
    response.transform(utf8.decoder).listen(contents.write,
        onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  Uri makeUri(String url, Map<String, dynamic>? parametrs) {
    final uri = Uri.parse(url);

    if (parametrs != null) {
      return uri.replace(queryParameters: parametrs);
    } else {
      return uri;
    }
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
