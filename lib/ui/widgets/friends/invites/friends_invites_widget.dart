import 'package:flutter/material.dart';
import 'package:glass_of_water/ui/themes/app_colors.dart';
import 'package:glass_of_water/ui/widgets/friends/invites/friends_invites_model.dart';
import 'package:provider/provider.dart';

class FriendsInvitesWidget extends StatefulWidget {
  final List invites;

  const FriendsInvitesWidget({Key? key, required this.invites})
      : super(key: key);

  @override
  State<FriendsInvitesWidget> createState() => _FriendsInvitesWidgetState();
}

class _FriendsInvitesWidgetState extends State<FriendsInvitesWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<FriendsInvitesModel>();
    return Scaffold(
      backgroundColor: AppColors.mainLightGrey,
      appBar: AppBar(),
      body: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemExtent: 120,
        itemCount: widget.invites.length,
        itemBuilder: (context, index) {
          final invite = widget.invites[index];
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
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          invite['initiator']['username'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                          const TextStyle(fontWeight: FontWeight.bold),
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
                ),
                TextButton(
                  onPressed: () {
                    model.acceptInvite(invite['id']);
                  },
                  child: Text('accept invite'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
