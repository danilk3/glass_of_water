import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/navigation/main_navigation.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass of water',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainLightGrey,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainLightBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
       routes: mainNavigation.routes,
       initialRoute: mainNavigation.initialRoute(false),
    );
  }
}
