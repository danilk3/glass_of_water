import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/widgets/friends/friends_model.dart';
import 'package:glass_of_water/ui/widgets/friends/friends_widget.dart';
import 'package:glass_of_water/ui/widgets/history/history_model.dart';
import 'package:glass_of_water/ui/widgets/history/history_widget.dart';
import 'package:glass_of_water/ui/widgets/profile/profile_model.dart';
import 'package:glass_of_water/ui/widgets/profile/profile_widget.dart';
import 'package:glass_of_water/ui/widgets/trip.dart/trip_model.dart';
import 'package:glass_of_water/ui/widgets/trip.dart/trip_widget.dart';
import 'package:glass_of_water/utils/permission_handler.dart';
import 'package:provider/provider.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  void initState() {
    super.initState();
    PermissionHandler().checkPermission();
  }

  int _selectedTab = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ChangeNotifierProvider(
      create: (_) => TripModel(),
      child: const TripWidget(),
    ),
    ChangeNotifierProvider(
      create: (_) => HistoryModel(),
      child: const HistoryWidget(),
    ),
    ChangeNotifierProvider(
      create: (_) => FriendsModel(),
      child: const FriendsWidget(),
    ),
    ChangeNotifierProvider(
      create: (_) => ProfileModel(),
      child: const ProfileWidget(),
    )
  ];

  void onSelectedTab(int index) {
    if (_selectedTab == index) {
      return;
    }

    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGrey,
      appBar: AppBar(
        title: const Center(child: Text('Glass of water')),
        centerTitle: true,
      ),
      body: _widgetOptions[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: onSelectedTab,
      ),
    );
  }
}
