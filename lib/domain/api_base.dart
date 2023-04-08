import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:glass_of_water/data_providers/user_data_provider.dart';
import 'package:glass_of_water/models/driver/level_enum.dart';

class ApiBase {
  final client = HttpClient();
  final userDataProvider = UserDataProvider();

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

  Future<int> getUserId() async {
    var userId = int.parse(await userDataProvider.getUserId() ?? '-1');
    return userId;
  }

  Future<String> getUserName() async {
    return await userDataProvider.getUserName() ?? "";
  }

  Future<String> getUserLevel() async {
    return await userDataProvider.getUserLevel() ?? "";
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
