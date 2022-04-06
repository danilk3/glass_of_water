import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/themes/button_style.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGrey,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 75),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(image: AssetImage(AppImages.logo)),
              SizedBox(
                width: 25,
              ),
              Text(
                'Glass\nof\nwater',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: _FormWidget(),
          ),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final model = NotifierProvider.read<AuthModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //const _ErrorMessageWidget(),
        Text(
          'Email',
          style: AppTextStyle.inputLabelStyle,
        ),
        const SizedBox(height: 7),
        const TextField(
          //controller: model?.loginTextController,
          decoration: AppTextStyle.inputDecoration,
        ),
        const _LogInCodeWidget(),
      ],
    );
  }
}

class _LogInCodeWidget extends StatelessWidget {
  const _LogInCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 35),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'We just send you a temporary sign up code. Please check your inbox and paste the sign up code below.',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 35),
        Text(
          'Log in code',
          style: AppTextStyle.inputLabelStyle,
        ),
        const SizedBox(height: 7),
        const TextField(
          //controller: model?.loginTextController,
          decoration: AppTextStyle.inputDecoration,
        ),
        const SizedBox(height: 25),
        const _AuthButtonWidget(),
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final model = NotifierProvider.watch<AuthModel>(context);
    // final child = model?.canStartAuth == false
    //     ? const SizedBox(
    //         width: 15,
    //         height: 15,
    //         child: CircularProgressIndicator(
    //           strokeWidth: 2,
    //         ),
    //       )
    //     : const Text("Войти");
    return TextButton(
      //onPressed: model?.canStartAuth == true ? () => model?.auth(context) : null,
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen);
      },
      style: AppButtonStyle.filledButton,
      child: const Text('Log in'),
    );
  }
}
