import 'package:flutter/material.dart';
import 'package:glass_of_water/data_providers/user_data_provider.dart';
import 'package:glass_of_water/domain/api_client.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';

class ProfileModel extends ChangeNotifier {
  final _userDataProvider = UserDataProvider();
  final _apiClient = ApiClient();

  void logOut(BuildContext context) {
    _userDataProvider.logOut();
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.auth);
  }

  Future deleteAccount(BuildContext context) async {
    await _apiClient.deleteAccount(int.parse(await _userDataProvider.getUserId() ?? '0'));
    _userDataProvider.logOut();
    Navigator.of(context).pop();
    await Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.auth);
  }
}
