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
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
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
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
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
