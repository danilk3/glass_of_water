import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGrey,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'About the app',
                style: AppTextStyle.titleStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'This mobile application will help users to track the accuracy of driving. It will be useful for people who do not have much driving experience, or people who want to evaluate their driving skills.',
              style: AppTextStyle.profileInfoStyle,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'About us',
                style: AppTextStyle.titleStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'We are a team of students from the Higher School of Economics, Faculty of Computer Science. Made this app as part of a course project.',
              style: AppTextStyle.profileInfoStyle,
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  'Glass of water\n2022',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.profileInfoStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Image(
                  image: AssetImage(AppImages.logo),
                  height: 80,
                  width: 80,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
