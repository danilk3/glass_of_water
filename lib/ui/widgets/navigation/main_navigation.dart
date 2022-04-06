import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/widgets/auth/auth_widget.dart';
import 'package:glass_of_water/ui/widgets/info/info_widget.dart';
import 'package:glass_of_water/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:glass_of_water/ui/widgets/onboarding/onboarding.dart';

class MainNavigationRouteNames {
  static const mainScreen = '/';
  static const info = '/info';
  static const onboarding = 'onboarding';
  static const auth = 'auth';
}

class MainNavigation {
  String initialRoute(bool isAuth) => MainNavigationRouteNames.onboarding;
      

  final routes = <String, Widget Function(BuildContext)>{
    'onboarding': (context) => const OnboardingWidget(), 
    'auth': (context) => const AuthWidget(), 
    '/': (context) => const MainScreenWidget(), 
    '/info': (context) => const InfoWidget(), 
  };
}
