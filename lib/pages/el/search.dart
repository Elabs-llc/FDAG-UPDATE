import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  List<String> searchTerms = ['Edwin', 'Elabs', 'Elabs DeepMind', 'DrBrainz'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          Navigator.pop(context);
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var config in searchTerms) {
      if (config.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(config);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://api.adorable.io/avatars/285/$index.png',
              ),
            ),
            title: Text(matchQuery[index]),
            onTap: () {
              Navigator.pushNamed(context, '/detail',
                  arguments: matchQuery[index]);
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var config in searchTerms) {
      if (config.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(config);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://api.adorable.io/avatars/285/$index.png',
              ),
            ),
            title: Text(matchQuery[index]),
            onTap: () {
              Navigator.pushNamed(context, '/detail',
                  arguments: matchQuery[index]);
            },
          );
        });
  }
}
