import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/trip.dart/trip_model.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;
import 'package:glass_of_water/utils/permission_handler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class TripWidget extends StatefulWidget {
  const TripWidget({Key? key}) : super(key: key);

  @override
  State<TripWidget> createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget>
    with SingleTickerProviderStateMixin {
  bool isSplashing = false;

  void startTimer() {
    var _start = 5;
    const oneSec = const Duration(seconds: 1);
    final _timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (_start == 0) {
          setState(() {
            print('timer over');
            isSplashing = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<TripModel>();
    return Column(
      children: [
        SizedBox(
          height: 450,
          child: (watch.shouldSpill == true || isSplashing == true)
              ? Lottie.asset(
                  'animations/Splash_short.json',
                  onLoaded: (comp) {
                    isSplashing = true;
                    startTimer();
                  },
                )
              : Lottie.asset('animations/bubbles.json'),
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
