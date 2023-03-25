import 'dart:convert';

import 'package:glass_of_water/domain/api_base.dart';
import 'package:glass_of_water/resources/resources.dart';

class FriendsService extends ApiBase {
  static const _host = AppConfig.clientHost;

  Future<void> inviteUser(String receiverUsername) async {
    final username = await getUserName();
    final url = makeUri('$_host/friends', null);

    final requestBody = <String, dynamic>{
      'initiatorUsername': username,
      'receiverUsername': receiverUsername
    };

    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json');
    request.write(jsonEncode(requestBody));

    await request.close();
  }

  Future<List> getFriends() async {
    final id = await getUserId();

    final url = makeUri('$_host/friends/$id', null);

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    final response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<List> getInvites() async {
    final userId = await getUserId();

    final url =
        makeUri('$_host/friends/invite/', {'user_id': userId}.map((key, value) => MapEntry(key, value.toString())));

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    final response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<List> getInitiations() async {
    final userId = await getUserId();

    final url =
        makeUri('$_host/friends/initiation/', {'user_id': userId}.map((key, value) => MapEntry(key, value.toString())));

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    final response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }

  Future<void> acceptInvite(int inviteId) async {
    final url = makeUri('$_host/friends/invite/$inviteId', null);
    final request = await client.patchUrl(url);
    await request.close();
  }

  Future<List> getNotFriends() async {
    final id = await getUserId();

    final url = makeUri('$_host/friends/$id/not_friends', null);

    final request = await client.getUrl(url);
    request.headers.set('Content-type', 'application/json');

    final response = await request.close();

    final body = json.decode(await readResponse(response));

    return body;
  }
}
