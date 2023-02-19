import 'package:flutter/material.dart';
import 'package:glass_of_water/Inherited/provider.dart';
import 'package:glass_of_water/ui/friends/friends_widget.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/widgets/history/history_widget.dart';
import 'package:glass_of_water/ui/widgets/profile/profile_widget.dart';
import 'package:glass_of_water/ui/widgets/trip.dart/trip_model.dart';
import 'package:glass_of_water/ui/widgets/trip.dart/trip_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    NotifierProvider(
      model: TripModel(),
      child: const TripWidget(),
    ),
    HistoryWidget(),
    const FriendsWidget(),
    const ProfileWidget(),
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
