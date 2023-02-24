import 'package:flutter/material.dart';
import 'package:glass_of_water/models/trip.dart';
import 'package:glass_of_water/ui/widgets/auth/auth_model.dart';
import 'package:glass_of_water/ui/widgets/auth/auth_widget.dart';
import 'package:glass_of_water/ui/widgets/info/info_widget.dart';
import 'package:glass_of_water/ui/widgets/main_screen/main_screen_model.dart';
import 'package:glass_of_water/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:glass_of_water/ui/widgets/onboarding/onboarding.dart';
import 'package:glass_of_water/ui/widgets/trip_details/trip_details.dart';
import 'package:glass_of_water/ui/widgets/trip_details/trip_details_model.dart';
import 'package:glass_of_water/ui/widgets/trip_results/trip_results_model.dart';
import 'package:glass_of_water/ui/widgets/trip_results/trip_results_widget.dart';
import 'package:provider/provider.dart';

class MainNavigationRouteNames {
  static const tripDetails = '/trip_details';
  static const mainScreen = '/';
  static const info = '/info';
  static const onboarding = 'onboarding';
  static const auth = 'auth';
  static const tripResults = '/trip_results';
  static const aboutUs = '/info/about_us';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.onboarding;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.onboarding: (context) => const OnboardingWidget(),
    MainNavigationRouteNames.tripDetails: (context) {
      final arg = ModalRoute.of(context)!.settings.arguments as Trip;
      return ChangeNotifierProvider(
        create: (_) => TripDetailsModel(),
        child: TripDetailsWidget(trip: arg),
      );
    },
    MainNavigationRouteNames.auth: (context) => ChangeNotifierProvider(
          create: (_) => AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRouteNames.mainScreen: (context) => ChangeNotifierProvider(
          create: (_) => MainScreenModel(),
          child: const MainScreenWidget(),
        ),
    MainNavigationRouteNames.aboutUs: (context) => const InfoWidget(),
    MainNavigationRouteNames.tripResults: (context) {
      final arg = ModalRoute.of(context)!.settings.arguments as List;
      return ChangeNotifierProvider(
        create: (_) => TripResultsModel(),
        child: TripResultsWidget(
          numberOfSpills: arg[0],
          elapsedMilliseconds: arg[1],
        ),
      );
    }
  };
}
