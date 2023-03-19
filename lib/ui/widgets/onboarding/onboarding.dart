import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/widgets/onboarding/onboarding_model.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../navigation/main_navigation.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({Key? key}) : super(key: key);

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  final _pages = [
    PageViewModel(
      title: 'Personal car insturctor',
      body: 'Improve your driving skills in every ride',
      image: const Center(
        child: Image(image: AssetImage(AppImages.onboardingImage1)),
      ),
    ),
    PageViewModel(
      title: 'Compete with others',
      body: 'Compare your results with other users',
      image: const Center(
        child: Image(image: AssetImage(AppImages.onboardingImage2)),
      ),
    ),
    PageViewModel(
      title: 'Improve your status',
      body: 'Get rewards for your success',
      image: const Center(
        child: Image(image: AssetImage(AppImages.onboardingImage3)),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    OnboardingModel().setIsFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGrey,
      body: IntroductionScreen(
        pages: _pages,
        onDone: () {
          Navigator.of(context)
              .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
        },
        showBackButton: false,
        showSkipButton: true,
        showNextButton: false,
        skip: const Text(
          'Skip',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        done: const Text(
          'Get started',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
