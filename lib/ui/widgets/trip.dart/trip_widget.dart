import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:lottie/lottie.dart';

class TripWidget extends StatefulWidget {
  const TripWidget({Key? key}) : super(key: key);

  @override
  State<TripWidget> createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const _StatisticsButtonWidget(),
        SizedBox(
          height: 500,
          child: Lottie.asset('animations/stable_glass.json'),
        ),
        const _StartTripButtonWidget(),
        const SizedBox(
          height: 20,
        ),
      ],
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
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.9,
                child: Container(
                  color: Colors.red,
                  child: Column(
                    children: const [
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                ),
              );
            },
          );
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
