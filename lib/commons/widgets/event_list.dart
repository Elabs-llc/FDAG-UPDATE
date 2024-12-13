import 'package:fdag/elabs/auth/app_model.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final String collection;
  final String selectedCategory;
  final Map<String, String> categoryTitles;
  final Map<String, Map<String, String>> authorData;
  final Future<Map<String, String>> Function(String authorId)
      fetchAuthorDetails;

  const EventList({
    super.key,
    required this.collection,
    required this.selectedCategory,
    required this.categoryTitles,
    required this.authorData,
    required this.fetchAuthorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: AppModel().fetchEvents(collection, selectedCategory),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.isEmpty) {
          return const Center(child: Text("No events available."));
        }

        var events = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: events.length,
          itemBuilder: (context, index) {
            var event = events[index];
            String categoryTitle =
                categoryTitles[event['category']] ?? 'Unknown Category';
            String authorId = event['createdBy'] ?? '';
            var author =
                authorData[authorId] ?? {'name': 'FDAG', 'profilePic': ''};

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Image.network(event['imageUrl'], fit: BoxFit.cover),
                  ListTile(
                    title: Text(event['title']),
                    subtitle: Text(event['desc']),
                    leading: CircleAvatar(
                      backgroundImage: author['profilePic']!.isNotEmpty
                          ? NetworkImage(author['profilePic']!)
                          : const AssetImage('assets/images/placeholder.png')
                              as ImageProvider,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
