import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/themes/text_style.dart';
import 'package:glass_of_water/ui/widgets/friends/friends_model.dart';
import 'package:glass_of_water/ui/widgets/friends/search_friends/search_delegate.dart';
import 'package:glass_of_water/ui/widgets/help_widgets/help_widgets.dart';
import 'package:glass_of_water/utils/globals.dart' as globals;
import 'package:provider/provider.dart';

import '../../../navigation/main_navigation.dart';

class FriendsWidget extends StatefulWidget {
  const FriendsWidget({Key? key}) : super(key: key);

  @override
  State<FriendsWidget> createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
  @override
  void initState() {
    if (globals.isAuth) {
      final model = context.read<FriendsModel>();
      model.getFriendsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!globals.isAuth) {
      return Center(
        child: TextButton(
            child: const Text("Login"),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(MainNavigationRouteNames.auth);
            }),
      );
    }
    final watch = context.watch<FriendsModel>();

    return watch.isLoading
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
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Friends',
                        style: AppTextStyle.titleStyle,
                      ),
                    ),
                    badges.Badge(
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Colors.blue,
                      ),
                      badgeContent: Text(
                        '${watch.invites.length}',
                        style: TextStyle(color: Colors.white),
                      ),
                      showBadge: watch.invites.isNotEmpty,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            MainNavigationRouteNames.friends_invites,
                            arguments: watch.invites,
                          );
                        },
                        icon: const Icon(
                          Icons.person_add,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    IconButton(
                      onPressed: () {
                        showSearch(
                          context: context,
                          // delegate to customize the search bar
                          delegate: FriendsSearchDelegate(watch.userList),
                        );
                      },
                      icon: const Icon(
                        Icons.person_search,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemExtent: 120,
                    itemCount: watch.friendsList.length,
                    itemBuilder: (context, index) {
                      final _user = watch.friendsList[index];
                      return Stack(
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Text(
                                          _user['username'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "rate: ${_user['rate']}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
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
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }
}
