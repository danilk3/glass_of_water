import 'package:flutter/material.dart';

import '../friends_model.dart';

class FriendsSearchDelegate extends SearchDelegate {
  late List users;

  final model = FriendsModel();

  FriendsSearchDelegate(this.users) {
    users = this.users;
  }

  @override
  String searchFieldLabel = 'Enter friend`s username';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        toolbarHeight: 80,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var user in users) {
      if (user['username'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(user['username']);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Row(
            children: [
              Text(
                result,
              ),
              TextButton(
                onPressed: () {
                  model.sendInvite(result);
                },
                child: Text('invite'),
              ),
            ],
          ),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var user in users) {
      if (user['username'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(user['username']);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Row(
            children: [
              Text(
                result,
              ),
              TextButton(
                onPressed: () {
                  model.sendInvite(result);
                },
                child: const Text('Invite'),
              ),
            ],
          ),
        );
      },
    );
  }
}
