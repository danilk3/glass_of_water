import 'package:glass_of_water/data_providers/user_data_provider.dart';

class MyAppModel {
  final _userDataProvider = UserDataProvider();
  var _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final userId = await _userDataProvider.getUserId();
    _isAuth = userId != null;
  }
}
