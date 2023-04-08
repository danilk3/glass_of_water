import 'package:flutter/material.dart';
import 'package:glass_of_water/navigation/main_navigation.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/trip/trip_model.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;
import 'package:glass_of_water/utils/permission_handler.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class TripWidget extends StatefulWidget {
  const TripWidget({Key? key}) : super(key: key);

  @override
  State<TripWidget> createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<TripModel>();

    final model = context.read<TripModel>();
    return Column(
      children: [
        if (globals.isAuth)
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 20, 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LiteRollingSwitch(
                  onTap: () {},
                  onDoubleTap: () {},
                  onChanged: (bool position) {
                    model.setIsSurvivalMode(position);
                  },
                  onSwipe: () {},
                  textOff: 'Regular',
                  colorOff: Colors.green,
                  iconOff: Icons.sentiment_very_satisfied,
                  textOn: 'Survival',
                  colorOn: Colors.red,
                  iconOn: Icons.sentiment_very_dissatisfied,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(MainNavigationRouteNames.carInfo);
                  },
                  icon: const Icon(
                    Icons.local_gas_station_outlined,
                    size: 40,
                  ),
                ),
              ],
            ),
          )
        else
          const SizedBox(
            height: 100,
          ),
        SizedBox(
            height: 450,
            child: (watch.shouldSpill == true)
                ? Lottie.asset(
                    'animations/Splash_short.json',
                    repeat: false,
                  )
                : Lottie.asset('animations/bubbles.json'),
            // child: _GlassWidget(watch: watch),
    ),
        if (watch.isTripStarted)
          _EndTripButtonWidget()
        else
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
    final model = context.read<TripModel>();
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: SizedBox(
          width: 300,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(255, 92, 0, 1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            onPressed: () {
              if (!globals.geolocationAllowed) {
                PermissionHandler().checkPermission();
                if (!globals.geolocationAllowed) {
                  return;
                }
              }
              showDialog(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 210, horizontal: 20),
                    child: AlertDialog(
                      content: SizedBox(
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              'Before you start your journey, make sure that your phone is secured to the holder or placed in a fixed position.',
                              style: AppTextStyle.profileOptionsStyle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                model.startTrip();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              child: Text(
                                'Accept',
                                style: AppTextStyle.profileOptionsStyle,
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
            child: Text(
              'Start Trip!',
              style: AppTextStyle.buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class _EndTripButtonWidget extends StatelessWidget {
  _EndTripButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<TripModel>();
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: SizedBox(
          width: 300,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 255, 0, 0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            onPressed: () {
              model.endTrip(context);
            },
            child: Text(
              'End Trip',
              style: AppTextStyle.buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
