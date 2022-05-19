import 'package:flutter/material.dart';
import 'package:glass_of_water/resources/resources.dart';
import 'package:glass_of_water/ui/widgets/challenges/challenge.dart';
import 'package:glass_of_water/ui/widgets/navigation/main_navigation.dart';

class ChallengesWidget extends StatefulWidget {
  ChallengesWidget({Key? key}) : super(key: key);

  @override
  State<ChallengesWidget> createState() => _ChallengesWidgetState();
}

class _ChallengesWidgetState extends State<ChallengesWidget> {
  final _challenges = [
    Challenge(
      id: 0,
      imageName: AppImages.glass1,
      title: 'Challenge #1',
      descripton: 'Challenge #1 description',
    ),
    Challenge(
      id: 1,
      imageName: AppImages.glass2,
      title: 'Challenge #2',
      descripton: 'Challenge #2 description',
    ),
    Challenge(
      id: 2,
      imageName: AppImages.glass3,
      title: 'Challenge #3',
      descripton: 'Challenge #3 description',
    ),
    Challenge(
      id: 3,
      imageName: AppImages.glass4,
      title: 'Challenge #4',
      descripton: 'Challenge #4 description',
    ),
    Challenge(
      id: 4,
      imageName: AppImages.glass5,
      title: 'Challenge #5',
      descripton: 'Challenge #5 description',
    ),
    Challenge(
      id: 5,
      imageName: AppImages.glass6,
      title: 'Challenge #6',
      descripton: 'Challenge #6 description',
    ),
    Challenge(
      id: 6,
      imageName: AppImages.glass7,
      title: 'Challenge #7',
      descripton: 'Challenge #7 description',
    ),
  ];

  void _onChallengeTap(int index) {
    final id = _challenges[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.challengeDetails,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: _challenges.length,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
        final _challenge = _challenges[index];
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
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Image(
                        image: AssetImage(
                          _challenge.imageName,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            _challenge.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _challenge.descripton,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => _onChallengeTap(index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
