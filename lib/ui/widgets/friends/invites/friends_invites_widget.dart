import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/friends/invites/friends_invites_model.dart';
import 'package:provider/provider.dart';

import '../../help_widgets/help_widgets.dart';

class FriendsInvitesWidget extends StatefulWidget {
  const FriendsInvitesWidget({Key? key}) : super(key: key);

  @override
  State<FriendsInvitesWidget> createState() => _FriendsInvitesWidgetState();
}

class _FriendsInvitesWidgetState extends State<FriendsInvitesWidget> {
  @override
  void initState() {
    super.initState();
    context.read<FriendsInvitesModel>().getInvites();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<FriendsInvitesModel>();
    final watch = context.watch<FriendsInvitesModel>();
    return Scaffold(
      backgroundColor: AppColors.mainLightGrey,
      appBar: AppBar(),
      body: watch.isLoading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (ctx, i) {
                    return Column(
                      children: [
                        HelpWidgets().loadingShimmer(),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }),
            )
          : watch.invites.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You have not invites(',
                        style: AppTextStyle.boldTextStyle,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemExtent: 100,
                    itemCount: watch.invites.length,
                    itemBuilder: (context, index) {
                      final invite = watch.invites[index];
                      return Container(
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      invite['initiator']['username'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "rate: ${invite['initiator']['rate']}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  model
                                    ..acceptInvite(invite['id'])
                                    ..getInvites();
                                },
                                child: const Text('Accept invite'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
