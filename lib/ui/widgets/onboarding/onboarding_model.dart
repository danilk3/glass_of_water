import '../../../data_providers/user_data_provider.dart';

class OnboardingModel {
  final _userDataProvider = UserDataProvider();

  void setIsFirstTime() {
    _userDataProvider.setIsFirstTime(false);
  }
}
