import 'package:flutter/material.dart';
import 'package:glass_of_water/Inherited/provider.dart';
import 'package:glass_of_water/models/trip.dart';
import 'package:glass_of_water/ui/widgets/auth/auth_model.dart';
import 'package:glass_of_water/ui/widgets/auth/auth_widget.dart';
import 'package:glass_of_water/ui/widgets/history/trip_details.dart';
import 'package:glass_of_water/ui/widgets/info/info_widget.dart';
import 'package:glass_of_water/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:glass_of_water/ui/widgets/onboarding/onboarding.dart';
import 'package:glass_of_water/ui/widgets/profile/profile_model.dart';
import 'package:glass_of_water/ui/widgets/profile/profile_widget.dart';
import 'package:glass_of_water/ui/widgets/trip.dart/trip_model.dart';
import 'package:glass_of_water/ui/widgets/trip.dart/trip_widget.dart';
import 'package:glass_of_water/ui/widgets/trip_results/trip_results_widget.dart';

class MainNavigationRouteNames {
  static const tripDetails = '/trip_details';
  static const mainScreen = '/';
  static const info = '/info';
  static const onboarding = 'onboarding';
  static const auth = 'auth';
  static const trip = '/trip';
  static const tripResults = '/trip_results';
  static const aboutUs = '/info/about_us';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.onboarding;

  final routes = <String, Widget Function(BuildContext)>{
    'onboarding': (context) => const OnboardingWidget(),
    '/trip_details': (context) {
      final arg = ModalRoute.of(context)!.settings.arguments as Trip;
      return TripDetailsWidget(trip: arg);
    },
    'auth': (context) => NotifierProvider(
          model: AuthModel(),
          child: const AuthWidget(),
        ),
    '/': (context) => const MainScreenWidget(),
    '/info': (context) => NotifierProvider(
          model: ProfileModel(),
          child: const ProfileWidget(),
        ),
    '/info/about_us': (context) => const InfoWidget(),
    '/trip': (context) => NotifierProvider(
          model: TripModel(),
          child: const TripWidget(),
        ),
    '/trip_results': (context) {
      final arg = ModalRoute.of(context)!.settings.arguments as List;
      return TripResultsWidget(
        numberOfSpills: arg[0],
        elapsedMilliseconds: arg[1],
      );
    }
  };
}
