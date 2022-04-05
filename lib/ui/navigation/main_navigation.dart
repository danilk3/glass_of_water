
import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/widgets/auth/auth_widget.dart';
import 'package:glass_of_water/ui/widgets/onboarding/onboarding.dart';

class MainNavigationRouteNames {
  static const mainScreen = '/';
  static const onboarding = 'onboarding';
  static const auth = 'auth';
}

class MainNavigation {
  String initialRoute(bool isAuth) => MainNavigationRouteNames.onboarding;
      

  final routes = <String, Widget Function(BuildContext)>{
    'onboarding': (context) => const OnboardingWidget(), 
    'auth': (context) => const AuthWidget(), 
  };
}
