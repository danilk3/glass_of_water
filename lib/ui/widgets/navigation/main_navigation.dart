import 'package:flutter/material.dart';
import 'package:glass_of_water/Inherited/provider.dart';
import 'package:glass_of_water/ui/widgets/auth/auth_model.dart';
import 'package:glass_of_water/ui/widgets/auth/auth_widget.dart';
import 'package:glass_of_water/ui/widgets/challenges/challenge_details.dart';
import 'package:glass_of_water/ui/widgets/info/info_widget.dart';
import 'package:glass_of_water/ui/widgets/main_screen/main_screen_model.dart';
import 'package:glass_of_water/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:glass_of_water/ui/widgets/onboarding/onboarding.dart';
import 'package:glass_of_water/ui/widgets/profile/profile_model.dart';
import 'package:glass_of_water/ui/widgets/profile/profile_widget.dart';
import 'package:glass_of_water/ui/widgets/trip.dart/trip_widget.dart';
import 'package:glass_of_water/ui/widgets/trip_results/trip_results_widget.dart';

class MainNavigationRouteNames {
  static const mainScreen = '/';
  static const info = '/info';
  static const onboarding = 'onboarding';
  static const auth = 'auth';
  static const challengeDetails = '/challenge_details';
  static const trip = '/trip';
  static const tripResults = '/trip_results';
}

class MainNavigation {
  String initialRoute(bool isAuth) =>
      isAuth ? MainNavigationRouteNames.mainScreen : MainNavigationRouteNames.onboarding;

  final routes = <String, Widget Function(BuildContext)>{
    'onboarding': (context) => const OnboardingWidget(),
    'auth': (context) => NotifierProvider(
          model: AuthModel(),
          child: const AuthWidget(),
        ),
    '/': (context) => NotifierProvider(
          model: MainScreenModel(),
          child: const MainScreenWidget(),
        ),
    '/info': (context) => NotifierProvider(
          model: ProfileModel(),
          child: const ProfileWidget(),
        ),
    '/trip': (context) => const TripWidget(),
    '/trip_results': (context) => const TripResultsWidget(),
    '/challenge_details': (context) {
      final arg = ModalRoute.of(context)!.settings.arguments;
      if (arg is int) {
        return ChallengeDetailsWidget(challengeId: arg);
      }
      return const ChallengeDetailsWidget(challengeId: 0);
    }
  };
}
