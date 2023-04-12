import 'package:flutter/material.dart';
import 'package:glass_of_water/navigation/main_navigation.dart';
import 'package:glass_of_water/resources/resources.dart';

class UnauthLoginWidget extends StatelessWidget {
  const UnauthLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const Image(
            image: AssetImage(AppImages.carLogin),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(MainNavigationRouteNames.auth);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
