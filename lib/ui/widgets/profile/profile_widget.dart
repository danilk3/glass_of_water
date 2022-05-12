import 'package:flutter/material.dart';
import 'package:glass_of_water/Inherited/provider.dart';
import 'package:glass_of_water/data_providers/user_data_provider.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';
import 'package:glass_of_water/ui/widgets/profile/profile_model.dart';
import 'package:glass_of_water/ui/widgets/profile/radial_percent_widget.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final modelsuper = ProfileModel();
  final _userDataProvider = UserDataProvider();

  String _email = '';
  String _name = '';
  int _rate = 0;

  bool _status = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final name = await _userDataProvider.getUserName() ?? '';
    final email = await _userDataProvider.getUserEmail() ?? '';
    final rate = int.parse(await _userDataProvider.getUserRate() ?? '0');

    setState(() {
      this._email = email;
      this._name = name;
      this._rate = rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<ProfileModel>(context);
    final watch = NotifierProvider.watch<ProfileModel>(context);
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
                Navigator.of(context).pushNamed(MainNavigationRouteNames.aboutUs);
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
                        modelsuper.logOut(context);
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
                              padding: const EdgeInsets.symmetric(vertical: 290, horizontal: 20),
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
                                          modelsuper.deleteAccount(context);
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
