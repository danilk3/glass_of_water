import 'package:flutter/cupertino.dart';
import 'package:glass_of_water/domain/client/friends/friends_service.dart';

class FriendsInvitesModel extends ChangeNotifier {
  final _friendService = FriendsService();

  bool isLoading = false;

  Future<void> acceptInvite(int inviteId) async {
    await _friendService.acceptInvite(inviteId);
  }

  late List invites;

  Future<void> getInvites() async {
    isLoading = true;
    invites = await _friendService.getInvites();
    isLoading = false;
    notifyListeners();
  }
}
