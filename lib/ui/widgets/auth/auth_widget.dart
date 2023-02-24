import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/auth/auth_model.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGrey,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
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
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: _FormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();
    final watch = context.watch<AuthModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: AppTextStyle.inputLabelStyle,
        ),
        const SizedBox(height: 7),
        TextField(
          controller: model?.emailTextController,
          decoration: AppTextStyle.inputDecoration,
        ),
        const _ErrorMessageEmailWidget(),
        const SizedBox(
          height: 10,
        ),
        const _SendCodeButtonWidget(),
        if (watch?.isCodeSend == true) const _LogInCodeWidget(),
      ],
    );
  }
}

class _LogInCodeWidget extends StatelessWidget {
  const _LogInCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'We just send you a temporary sign up code. Please check your inbox and paste the sign up code below.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(255, 106, 106, 106)),
          ),
        ),
        const SizedBox(height: 35),
        Text(
          'Log in code',
          style: AppTextStyle.inputLabelStyle,
        ),
        const SizedBox(height: 7),
        TextField(
          controller: model?.codeTextController,
          decoration: AppTextStyle.inputDecoration,
        ),
        const _ErrorMessageCodeWidget(),
        const SizedBox(height: 10),
        const _AuthButtonWidget(),
      ],
    );
  }
}

class _SendCodeButtonWidget extends StatelessWidget {
  const _SendCodeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();
    final watch = context.watch<AuthModel>();
    final text = watch?.isCodeSend == true ? 'Resend code' : 'Send login code';
    final child = watch?.isEmailSending == true
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        : Text(
            text,
            style: AppTextStyle.buttonTextStyle,
          );
    return Row(
      children: [
        Row(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    watch?.isTimerStarted == true ? Colors.grey : Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              onPressed: watch?.isCodeChecking == false &&
                      watch?.isTimerStarted == false
                  ? () => model?.sendEmail(context)
                  : null,
              child: child,
            ),
            const SizedBox(width: 5),
            if (watch?.isTimerStarted == true)
              Text('${watch?.remained} seconds'),
          ],
        ),
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
    final model = context.read<AuthModel>();
    final watch = context.watch<AuthModel>();
    final child = watch?.isCodeChecking == true
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        : Text(
            'Log in',
            style: AppTextStyle.buttonTextStyle,
          );
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      onPressed: watch?.isCodeChecking == false
          ? () => model?.validateCode(context)
          : null,
      child: child,
    );
  }
}

class _ErrorMessageEmailWidget extends StatelessWidget {
  const _ErrorMessageEmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.watch<AuthModel>()?.errorMessageEmail;

    if (errorMessage == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Color.fromARGB(255, 185, 49, 39)),
      ),
    );
  }
}

class _ErrorMessageCodeWidget extends StatelessWidget {
  const _ErrorMessageCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.watch<AuthModel>()?.errorMessageCode;

    if (errorMessage == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Color.fromARGB(255, 185, 49, 39)),
      ),
    );
  }
}
