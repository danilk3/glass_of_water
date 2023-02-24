import 'package:flutter/material.dart';
import 'package:glass_of_water/models/trip.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DrivingAdvice {
  String title;
  String description;

  DrivingAdvice({
    required this.title,
    required this.description,
  });
}

class TripDetailsWidget extends StatefulWidget {
  final Trip trip;

  TripDetailsWidget({Key? key, required this.trip}) : super(key: key);

  @override
  State<TripDetailsWidget> createState() => _TripDetailsWidgetState();
}

class _TripDetailsWidgetState extends State<TripDetailsWidget> {
  final advices = [
    DrivingAdvice(
      title: 'Think safety first',
      description:
          "Avoiding aggressive and inattentive driving tendencies yourself will put you in a stronger position to deal with other people's bad driving.",
    ),
    DrivingAdvice(
      title: 'Be aware of your surroundings',
      description:
          'Check your mirrors frequently and scan conditions 20 to 30 seconds ahead of you. Keep your eyes moving. ',
    ),
    DrivingAdvice(
      title: 'Do not depend on other drivers',
      description:
          'Be considerate of others but look out for yourself. Do not assume another driver is going to move out of the way or allow you to merge.',
    ),
    DrivingAdvice(
      title: 'Follow the 3- to 4-second rule',
      description:
          ' Since the greatest chance of a collision is in front of you, using the 3- to 4-second rule will help you establish and maintain a safe following distance.',
    ),
    DrivingAdvice(
      title: 'Keep your speed down',
      description:
          "Posted speed limits apply to ideal conditions. It's your responsibility to ensure that your speed matches conditions.",
    ),
    DrivingAdvice(
      title: 'Have an escape route',
      description:
          'In all driving situations, the best way to avoid potential dangers is to position your vehicle where you have the best chance of seeing.',
    ),
    DrivingAdvice(
      title: 'Separate risks',
      description:
          "When faced with multiple risks, it's best to manage them one at a time. Your goal is to avoid having to deal with too many risks at the same time.",
    ),
    DrivingAdvice(
      title: 'Cut out distractions',
      description:
          ' A distraction is any activity that diverts your attention from the task of driving. Driving deserves your full attention — so stay focused on the driving task.',
    ),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGrey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Trip results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                const _StatisticsTextWidget(
                  text: 'Rating of the trip',
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 200,
                  ),
                  child: LinearPercentIndicator(
                    lineHeight: 25,
                    percent: widget.trip.rate / 100.0,
                    center: Text(
                      '${widget.trip.rate}%',
                      style: const TextStyle(),
                    ),
                    progressColor:
                        AppColors.getProgressColor(widget.trip.rate / 100.0),
                  ),
                ),
                _StatisticsTextWidget(
                  text:
                      'Number of glass spills: ${widget.trip.numberOfGlasses}',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Travel time: ',
                        style: AppTextStyle.profileOptionsStyle,
                      ),
                      Text(
                        '${widget.trip.tripTime}',
                        style: AppTextStyle.profileOptionsBoldStyle,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Start time: ',
                        style: AppTextStyle.profileOptionsStyle,
                      ),
                      Text(
                        '${widget.trip.startTime}',
                        style: AppTextStyle.profileOptionsBoldStyle,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    itemCount: advices.length,
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (index) => setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    advices[i].title,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    advices[i].description,
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _StatisticsTextWidget extends StatelessWidget {
  final String text;

  const _StatisticsTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: AppTextStyle.profileOptionsStyle,
        ),
      ),
    );
  }
}
