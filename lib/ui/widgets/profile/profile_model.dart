import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glass_of_water/data_providers/user_data_provider.dart';
import 'package:glass_of_water/domain/client/user/user_service.dart';
import 'package:glass_of_water/models/driver/level.dart';
import 'package:glass_of_water/navigation/main_navigation.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfileModel extends ChangeNotifier {
  final _userDataProvider = UserDataProvider();
  final _userService = UserService();
  final ImagePicker _imagePicker = ImagePicker();
  var usernameTextController;

  String? _errorMessageUsername;

  String? get errorMessageUsername => _errorMessageUsername;

  String _level = '';
  String get level => _level;


  String _email = '';
  String get email => _email;

  String _name = '';
  String get name => _name;

  int _rate = 0;
  int get rate => _rate;

  String? _imagePath;

  String? get imagePath => _imagePath;

  void logOut(BuildContext context) {
    globals.isAuth = false;
    _userDataProvider.logOut();
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }

  Future deleteAccount(BuildContext context) async {
    await _userService.deleteAccount();
    globals.isAuth = false;
    await _userDataProvider.logOut();
    await Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }

  Future<void> getUserInfo() async {
    _name = await _userDataProvider.getUserName() ?? '';
    _email = await _userDataProvider.getUserEmail() ?? '';
    _rate = int.parse(await _userDataProvider.getUserRate() ?? '0');
    _userDataProvider.getUserLevel();
    _level = (await _userDataProvider.getUserLevel())!;
    _imagePath = await _userDataProvider.getAvatarPath();
    usernameTextController = TextEditingController(text: _name);
    notifyListeners();
  }

  Future<void> pickImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final path = (await getApplicationDocumentsDirectory()).path;
    final fileName = basename(image.path);
    var avatarPath = '$path/$fileName';
    await image.saveTo(avatarPath);
    await _userDataProvider.setAvatarPath(avatarPath);
    _imagePath = avatarPath;
    notifyListeners();
  }

  Future<void> updateUsername() async {
    final newUsername = usernameTextController.text.trim();

    if (newUsername == '' || newUsername.length > 14) {
      _errorMessageUsername = 'Invalid username';
      notifyListeners();
      usernameTextController = TextEditingController(text: _name);
      startTimer();
      return;
    }

    if (newUsername == _name) {
      return;
    }

    try {
      await _userService.updateUser(<String, dynamic>{'username': newUsername});
    } catch (e) {
      _errorMessageUsername = 'User with this name already exists';
      notifyListeners();
      usernameTextController = TextEditingController(text: _name);
      startTimer();
      return;
    }

    _userDataProvider.setUserName(newUsername);
    _name = newUsername;
    notifyListeners();
  }

  Future<void> startTimer() async {
    var _start = 3;
    notifyListeners();
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
          (timer) {
        if (_start == 0) {
          timer.cancel();
          _errorMessageUsername = null;
          notifyListeners();
        } else {
          _start--;
          notifyListeners();
        }
      },
    );
  }
}
