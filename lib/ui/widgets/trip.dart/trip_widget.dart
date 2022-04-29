import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:sensors_plus/sensors_plus.dart';

class TripWidget extends StatefulWidget {
  const TripWidget({Key? key}) : super(key: key);

  @override
  State<TripWidget> createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget> {
  double x = 0, y = 0, z = 0;
  String direction = "none";

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      //print(event);

      x = event.x;
      y = event.y;
      z = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orentation
      if (x > 0) {
        direction = "back";
      } else if (x < 0) {
        direction = "forward";
      } else if (y > 0) {
        direction = "left";
      } else if (y < 0) {
        direction = "right";
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 450,
          child: Lottie.asset('animations/Splash_short.json'),
        ),
        //const _StatisticsButtonWidget(),
        Text(direction, style: AppTextStyle.inputLabelStyle,),
        const _StartTripButtonWidget(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _StartTripButtonWidget extends StatelessWidget {
  const _StartTripButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: SizedBox(
          width: 300,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color.fromRGBO(255, 92, 0, 1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              'GO!',
              style: AppTextStyle.buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatisticsButtonWidget extends StatelessWidget {
  const _StatisticsButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 80,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(MainNavigationRouteNames.tripResults);
        },
        child: Text(
          'Look at the statistics of the last trip!',
          textAlign: TextAlign.center,
          style: AppTextStyle.buttonTextStyle,
        ),
      ),
    );
  }
}
