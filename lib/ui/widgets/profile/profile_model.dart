import 'package:flutter/material.dart';
import 'package:glass_of_water/data_providers/user_data_provider.dart';
import 'package:glass_of_water/domain/client/user/user_service.dart';
import 'package:glass_of_water/models/driver/level.dart';
import 'package:glass_of_water/navigation/main_navigation.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfileModel extends ChangeNotifier {
  final _userDataProvider = UserDataProvider();
  final _userService = UserService();
  final ImagePicker _imagePicker = ImagePicker();

  String _email = '';
  String _name = '';
  int _rate = 0;

  Level _level = Level.buildLevel('beginner');

  int get rate => _rate;

  String get name => _name;

  String get email => _email;
  Level get level => _level;

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
    final s = await _userDataProvider.getUserLevel();
    _level = Level.buildLevel('beginner');
    _imagePath = await _userDataProvider.getAvatarPath();
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
    // TODO: добавить отправку в апи
  }
}
