import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/models/trip.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HistoryWidget extends StatelessWidget {
  HistoryWidget({Key? key}) : super(key: key);

  final _trips = [
    Trip(
      id: 0,
      roadImage: AppImages.testingRoadMap,
      date: '12.01.2021 15:14',
    ),
    Trip(
      id: 0,
      roadImage: AppImages.testingRoadMap,
      date: '22.09.2021 12:14',
    ),
    Trip(
      id: 0,
      roadImage: AppImages.testingRoadMap,
      date: '12.02.2021 09:20',
    ),
    Trip(
      id: 0,
      roadImage: AppImages.testingRoadMap,
      date: '11.01.2021 22:10',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: _trips.length,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
        final _trip = _trips[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
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
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Image(
                        image: AssetImage(
                          _trip.roadImage,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              _trip.date,
                              style: AppTextStyle.profileInfoStyle,
                            ),
                          ),
                          const SizedBox(height: 20),
                          LinearPercentIndicator(
                            width: 200,
                            lineHeight: 20,
                            percent: 0.3,
                            center: const Text(
                              '30%',
                              style: TextStyle(),
                            ),
                            progressColor: AppColors.getProgressColor(0.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
