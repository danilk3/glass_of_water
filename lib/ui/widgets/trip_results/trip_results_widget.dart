import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/trip.dart/test_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TripResultsWidget extends StatefulWidget {
  final numberOfSpills;
  final elapsedMilliseconds;

  const TripResultsWidget(
      {Key? key, required this.numberOfSpills, required this.elapsedMilliseconds})
      : super(key: key);

  @override
  State<TripResultsWidget> createState() => _TripResultsWidgetState();
}

class _TripResultsWidgetState extends State<TripResultsWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    int hours = widget.elapsedMilliseconds ~/ 3600000;
    int minutes = (widget.elapsedMilliseconds ~/ 60000) % 60;
    int seconds = (widget.elapsedMilliseconds ~/ 1000) % 60;
    String? hoursString;
    String? minutesString;
    String? secondsString;

    if (hours < 10) {
      hoursString = '0$hours';
    } else {
      hoursString = '$hours';
    }

    if (minutes < 10) {
      minutesString = '0$minutes';
    } else {
      minutesString = '$minutes';
    }

    if (seconds < 10) {
      secondsString = '0$seconds';
    } else {
      secondsString = '$seconds';
    }

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
                //const _ChallengeResultWidget(),
                _StatisticsTextWidget(
                  text: 'Rating of the trip. Spills = ${widget.numberOfSpills}',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: LinearPercentIndicator(
                    lineHeight: 25,
                    percent: 0.7,
                    center: const Text(
                      '70%',
                      style: TextStyle(),
                    ),
                    progressColor: AppColors.getProgressColor(0.7),
                  ),
                ),
                const _StatisticsTextWidget(
                  text: 'Spilled glasses',
                ),
                SizedBox(
                  height: 30,
                  child: Container(color: Colors.blue),
                ),
                const _StatisticsTextWidget(
                  text: 'Average for a similar route',
                ),
                const LineChartSample2(),
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
                        'Average speed: ',
                        style: AppTextStyle.profileOptionsStyle,
                      ),
                      Text(
                        '45 km\\h',
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
                        'Travel time: ',
                        style: AppTextStyle.profileOptionsStyle,
                      ),
                      Text(
                        '$hoursString:$minutesString:$secondsString',
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
                        'Path length: ',
                        style: AppTextStyle.profileOptionsStyle,
                      ),
                      Text(
                        '50 km',
                        style: AppTextStyle.profileOptionsBoldStyle,
                      )
                    ],
                  ),
                ),
                const _StatisticsTextWidget(
                  text: 'Road map',
                ),
                const SizedBox(
                  height: 300,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(37.42796133580664, -122.085749655962),
                      zoom: 14.4746,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    itemCount: 10,
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (int index) => setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              "Card ${i + 1}",
                              style: TextStyle(fontSize: 32),
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

class _ChallengeResultWidget extends StatelessWidget {
  const _ChallengeResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.successGreen,
          border: Border.all(
            color: AppColors.successGreen.withOpacity(0.2),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Challenge #1',
                style: AppTextStyle.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Done',
                    style: AppTextStyle.subTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.done_outline),
                ],
              )
            ],
          ),
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
