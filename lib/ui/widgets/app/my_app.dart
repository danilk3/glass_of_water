import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass of water',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainLightBlue,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainLightBlue,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
        ),
      ),
       routes: mainNavigation.routes,
       initialRoute: mainNavigation.initialRoute(false),
    );
  }
}
