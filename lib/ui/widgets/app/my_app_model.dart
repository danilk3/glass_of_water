import 'package:glass_of_water/data_providers/user_data_provider.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;

class MyAppModel {
  final _userDataProvider = UserDataProvider();

  var _isFirstTime = false;

  bool get isFirstTime => _isFirstTime;

  Future<void> checkAuth() async {
    final userId = await _userDataProvider.getUserId();
    _isFirstTime = (await _userDataProvider.getIsFirstTime()) == null;
    globals.isAuth = userId != null;

    if (_isFirstTime == true) {
      await _userDataProvider.setIsFirstTime(true);
    }
  }
}
