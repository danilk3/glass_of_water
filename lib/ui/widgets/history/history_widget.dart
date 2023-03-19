import 'package:flutter/material.dart';
import 'package:glass_of_water/models/trip.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../navigation/main_navigation.dart';
import 'history_model.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  List _trips = [];

  @override
  void initState() {
    super.initState();
    if (globals.isAuth) {
      asyncInit();
    }
  }

  Future<void> asyncInit() async {
    final model = context.read<HistoryModel>();
    await model.getTrips();
    final trips = model.trips;

    setState(() {
      _trips = trips!;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!globals.isAuth) {
      return Center(
        child: TextButton(
            child: const Text("Login"),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.auth);
            }),
      );
    }
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
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              _trip['startTime'],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Rating:',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 15),
                          LinearPercentIndicator(
                            width: 200,
                            lineHeight: 20,
                            percent: _trip["rate"] / 100.0,
                            center: Text(
                              '${_trip["rate"]}%',
                              style: TextStyle(),
                            ),
                            progressColor: AppColors.getProgressColor(
                                _trip["rate"] / 100.0),
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
                  onTap: () => {
                    Navigator.of(context).pushNamed(
                        MainNavigationRouteNames.tripDetails,
                        arguments: Trip(
                            rate: _trip["rate"],
                            numberOfGlasses: _trip["countOfGlasses"],
                            tripTime: _trip["time"],
                            startTime: _trip["startTime"]))
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
