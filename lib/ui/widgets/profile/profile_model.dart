import 'package:flutter/material.dart';
import 'package:glass_of_water/data_providers/user_data_provider.dart';
import 'package:glass_of_water/domain/api_client.dart';

import '../../../navigation/main_navigation.dart';

class ProfileModel extends ChangeNotifier {
  final _userDataProvider = UserDataProvider();
  final _apiClient = ApiClient();

  String _email = '';
  String _name = '';
  int _rate = 0;

  int get rate => _rate;

  String get name => _name;

  String get email => _email;

  void logOut(BuildContext context) {
    _userDataProvider.logOut();
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }

  Future deleteAccount(BuildContext context) async {
    await _apiClient.deleteAccount();
    _userDataProvider.logOut();
    Navigator.of(context).pop();
    await Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }

  Future<void> getUserInfo() async {
    _name = await _userDataProvider.getUserName() ?? '';
    _email = await _userDataProvider.getUserEmail() ?? '';
    _rate = int.parse(await _userDataProvider.getUserRate() ?? '0');
  }
}
