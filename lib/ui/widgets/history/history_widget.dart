import 'package:flutter/material.dart';
import 'package:glass_of_water/data_providers/user_data_provider.dart';
import 'package:glass_of_water/domain/api_client/api_client.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/models/trip.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HistoryWidget extends StatefulWidget {
  HistoryWidget({Key? key}) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {

  final _apiClient = ApiClient();
  List _trips = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final trips = await _apiClient.getAllTrips(int.parse(await UserDataProvider().getUserId() ?? '0'));

    setState(() {
      this._trips = trips;
    });
  }

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
                            center:  Text(
                              '${_trip["rate"]}%',
                              style: TextStyle(),
                            ),
                            progressColor: AppColors.getProgressColor(_trip["rate"] / 100.0),
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
                    Navigator.of(context).pushNamed(MainNavigationRouteNames.tripDetails, arguments: Trip(rate: _trip["rate"], numberOfGlasses: _trip["countOfGlasses"], tripTime: _trip["time"], startTime: _trip["startTime"]))
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
