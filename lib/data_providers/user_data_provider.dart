import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class Keys {
  static const userId = 'user_id';
  static const userName = 'user_name';
  static const userEmail = 'user_email';
  static const userRate = 'user_rate';
  static const isFirstTime = 'is_first_time';
  static const userLevel = 'user_level';
}

class UserDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<void> logOut() {
    return _secureStorage.delete(key: Keys.userId);
  }

  void initUser(Map<String, dynamic> userInfo) {
    setUserId(userInfo['id'].toString());
    setUserName(userInfo['username']?.toString());
    setUserRate(userInfo['rate']?.toString());
    setUserEmail(userInfo['email']?.toString());
  }

  Future<String?> getUserId() => _secureStorage.read(key: Keys.userId);

  Future<void> setUserId(String? value) {
    return _secureStorage.write(key: Keys.userId, value: value);
  }

  Future<String?> getUserName() => _secureStorage.read(key: Keys.userName);

  Future<void> setUserName(String? value) {
    return _secureStorage.write(key: Keys.userName, value: value);
  }

  Future<String?> getUserEmail() => _secureStorage.read(key: Keys.userEmail);

  Future<void> setUserEmail(String? value) {
    return _secureStorage.write(key: Keys.userEmail, value: value);
  }

  Future<String?> getUserRate() => _secureStorage.read(key: Keys.userRate);

  Future<void> setUserRate(String? value) {
    return _secureStorage.write(key: Keys.userRate, value: value);
  }

  Future<String?> getUserLevel() => _secureStorage.read(key: Keys.userLevel);

  Future<void> setUserLevel(String? value) {
    return _secureStorage.write(key: Keys.userLevel, value: value);
  }

  Future<void> setIsFirstTime(bool isFirstTime) {
    return _secureStorage.write(key: Keys.isFirstTime, value: isFirstTime.toString());
  }

  Future<String?> getIsFirstTime() {
    return _secureStorage.read(key: Keys.isFirstTime);
  }
}
