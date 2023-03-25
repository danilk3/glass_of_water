import 'package:flutter/cupertino.dart';
import 'package:glass_of_water/domain/client/friends/friends_service.dart';

class FriendsInvitesModel extends ChangeNotifier {
  final _friendService = FriendsService();

  void acceptInvite(int inviteId) {
    _friendService.acceptInvite(inviteId);
  }
}
