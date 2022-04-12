import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';

class ChallengeDetailsWidget extends StatefulWidget {
  const ChallengeDetailsWidget({Key? key, required this.challengeId}) : super(key: key);

  final int challengeId;

  @override
  State<ChallengeDetailsWidget> createState() => _ChallengeDetailsWidgetState();
}

class _ChallengeDetailsWidgetState extends State<ChallengeDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGrey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Challnge #1'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Image(
                  image: AssetImage(AppImages.glass1),
                ),
                const SizedBox(height: 30),
                Text(
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.",
                  style: AppTextStyle.profileInfoStyle,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text(
                    'Select challenge',
                    style: AppTextStyle.profileOptionsStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
