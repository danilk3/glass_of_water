import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';
import 'package:glass_of_water/ui/widgets/profile/radial_percent_widget.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool _status = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          SizedBox(
            width: 75,
            height: 75,
            child: RadialPercentWidget(
              // user`s rating
              percent: 0.3,
              lineWidth: 4,
              // user photo
              child: const Image(
                image: AssetImage(AppImages.defaultAvatar),
                height: 45,
                width: 45,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '30%',
            style: AppTextStyle.boldTextStyle,
          ),
          const SizedBox(height: 10),
          Text(
            // user`s name
            'Alex Smith',
            style: AppTextStyle.profileInfoStyle,
          ),
          const SizedBox(height: 10),
          Text(
            // user`s email
            'alexhero@mail.com',
            style: AppTextStyle.profileInfoStyle,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Show my trips to friends',
                  style: AppTextStyle.profileOptionsStyle,
                ),
                Switch(
                  value: _status,
                  onChanged: (val) {
                    setState(() {
                      _status = val;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark theme',
                  style: AppTextStyle.profileOptionsStyle,
                ),
                Switch(
                  value: _status,
                  onChanged: (val) {
                    setState(() {
                      _status = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(MainNavigationRouteNames.info);
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
                      onPressed: () {},
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
                            return AlertDialog(
                              content: SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    Text(
                                      'Are you sure you want to delete your account?',
                                      style: AppTextStyle.profileOptionsStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 15),
                                    ElevatedButton(
                                      onPressed: () {},
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
