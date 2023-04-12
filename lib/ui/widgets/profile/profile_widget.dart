import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/help_widgets/unauth_login_widget.dart';
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
  bool editName = false;

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
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfileModel>();
    final watch = context.watch<ProfileModel>();
    if (!globals.isAuth) {
      return const UnauthLoginWidget();
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
              percent: model.rate / 100,
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
            '${model.rate}%',
            style: AppTextStyle.boldTextStyle,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (editName)
                Container(
                  width: 100,
                  child: TextField(
                    // user`s name
                    style: AppTextStyle.profileInfoStyle,
                    controller: model.usernameTextController,
                  ),
                )
              else
                Text(
                  // user`s name
                  watch.name,
                  style: AppTextStyle.profileInfoStyle,
                ),
              if (editName)
                IconButton(
                  onPressed: () {
                    model.updateUsername();
                    setState(() {
                      editName = false;
                    });
                  },
                  icon: const Icon(
                    Icons.done,
                    color: Colors.blue,
                  ),
                )
              else
                IconButton(
                  onPressed: () {
                    setState(() {
                      editName = true;
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                )
            ],
          ),
          const _ErrorMessageEmailWidget(),
          Text(
            // user`s email
            model.email,
            style: AppTextStyle.profileInfoStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            // user`s email
            model.level,
            style: AppTextStyle.boldTextStyle,
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

class _ErrorMessageEmailWidget extends StatelessWidget {
  const _ErrorMessageEmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.watch<ProfileModel>().errorMessageUsername;

    if (errorMessage == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Color.fromARGB(255, 185, 49, 39)),
      ),
    );
  }
}
