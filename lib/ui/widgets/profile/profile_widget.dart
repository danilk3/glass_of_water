import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/profile/profile_model.dart';
import 'package:glass_of_water/ui/widgets/profile/radial_percent_widget.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;
import 'package:provider/provider.dart';

import '../../../navigation/main_navigation.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  String _email = '';
  String _name = '';
  int _rate = 0;

  @override
  void initState() {
    super.initState();
    if (globals.isAuth) {
      asyncInit();
    }
  }

  Future<void> asyncInit() async {
    final model = context.read<ProfileModel>();
    await model.getUserInfo();

    final name = model.name;
    final email = model.email;
    final rate = model.rate;

    setState(() {
      _email = email;
      _name = name;
      _rate = rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfileModel>();
    final watch = context.watch<ProfileModel>();
    if (!globals.isAuth) {
      return Center(
        child: TextButton(
          child: const Text("Login"),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(MainNavigationRouteNames.auth);
          },
        ),
      );
    }
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          SizedBox(
            width: 75,
            height: 75,
            child: RadialPercentWidget(
              // user`s rating
              percent: _rate / 100,
              lineWidth: 4,
              child: GestureDetector(
                onTap: model.pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: (watch.imagePath == null)
                          ? const AssetImage(AppImages.defaultAvatar)
                              as ImageProvider
                          : FileImage(
                              File(model.imagePath!),
                            ),
                      backgroundColor: Colors.white,
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$_rate%',
            style: AppTextStyle.boldTextStyle,
          ),
          const SizedBox(height: 10),
          Text(
            // user`s name
            _name,
            style: AppTextStyle.profileInfoStyle,
          ),
          const SizedBox(height: 10),
          Text(
            // user`s email
            _email,
            style: AppTextStyle.profileInfoStyle,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(MainNavigationRouteNames.aboutUs);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'About us',
                    style: AppTextStyle.profileOptionsStyle,
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        model.logOut(context);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.logout,
                            color: Color(0xFF212529),
                          ),
                          Text(
                            'Log out',
                            style: AppTextStyle.profileOptionsStyle,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 260, horizontal: 20),
                              child: AlertDialog(
                                content: SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Are you sure you want to delete your account?',
                                        style: AppTextStyle.profileOptionsStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          model.deleteAccount(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                        ),
                                        child: Text(
                                          'Delete account',
                                          style:
                                              AppTextStyle.profileOptionsStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text(
                        'Delete account',
                        style: AppTextStyle.profileOptionsStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
