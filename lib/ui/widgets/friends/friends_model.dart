import 'package:flutter/material.dart';
import 'package:glass_of_water/domain/client/friends/friends_service.dart';

class FriendsModel extends ChangeNotifier {
  final _friendService = FriendsService();

  bool isLoading = false;

  late List friendsList;

  // TODO: переделать запрос данных из апи
  late List userList;

  late List invites;

  Future<void> getFriendsList() async {
    isLoading = true;
    friendsList = await _friendService.getFriends();
    userList = await _friendService.getNotFriends();
    invites = await _friendService.getInvites();
    isLoading = false;
    notifyListeners();
  }

  void sendInvite(String receiverUsername) {
    _friendService.inviteUser(receiverUsername);
  }
}
