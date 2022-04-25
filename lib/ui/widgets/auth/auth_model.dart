import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:glass_of_water/domain/api_client/api_client.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiCLient = ApiClient();

  final emailTextController = TextEditingController();
  final codeTextController = TextEditingController();

  String? _errorMessageEmail;
  String? get errorMessageEmail => _errorMessageEmail;

  String? _errorMessageCode;
  String? get errorMessageCode => _errorMessageCode;

  bool _isCodeSend = false;
  bool get isCodeSend => _isCodeSend;

  bool _isEmailSending = false;
  bool get isEmailSending => _isEmailSending;

  bool _isCodeChecking = false;
  bool get isCodeChecking => _isCodeChecking;

  Future<void> sendEmail(BuildContext context) async {
    final email = emailTextController.text;

    if (email.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
      _errorMessageEmail = 'Wrong email';
      notifyListeners();
      return;
    }

    _errorMessageEmail = null;

    _isEmailSending = true;

    notifyListeners();

    bool? isSend;

    try {
      isSend = await _apiCLient.sendEmail(email: email);
    } catch (e) {
      _errorMessageEmail = 'There was an error sending one time password';
    }

    _isEmailSending = false;

    if (_errorMessageEmail != null || isSend == false || isSend == false) {
      notifyListeners();
      return;
    }
    _isCodeSend = true;
    startTimer();
    notifyListeners();
  }

  Future<void> validateCode(BuildContext context) async {
    final email = emailTextController.text;
    final code = codeTextController.text;

    if (code.isEmpty || code.length != 4) {
      _errorMessageCode = 'Wrong one time password';
      notifyListeners();
      return;
    }

    _errorMessageCode = null;

    _isCodeChecking = true;

    notifyListeners();

    bool? isSend;

    try {
      isSend = await _apiCLient.validateCode(email: email, code: code);
    } catch (e) {
      _errorMessageCode = 'Wrong one time password';
    }

    _isCodeChecking = false;

    if (_errorMessageCode != null || isSend == false || isSend == false) {
      _errorMessageCode = 'Wrong one time password';
      notifyListeners();
      return;
    }
    await Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }

  late Timer _timer;

  int _start = 20;
  int get remained => _start;
  bool get isTimerStarted => _start < 20;

  void startTimer() {
    notifyListeners();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        if (_start == 0) {
          _start = 20;
          timer.cancel();
          notifyListeners();
        } else {
          _start--;
          notifyListeners();
        }
      },
    );
  }
}
