import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:fdag/elabs/auth/app_model.dart';
import 'package:fdag/features/discover/view_all_page.dart';
import 'package:fdag/models/discover_model.dart';
import 'package:fdag/models/event_model.dart';
import 'package:fdag/pages/screens/event_details_page.dart';
import 'package:fdag/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // final List<String> _trendingTopics = [
  //   'Sustainable Fashion',
  //   'Digital Design',
  //   'Upcoming Designers',
  //   'Fashion Tech',
  //   'Local Artisans',
  //   'Eco Materials',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.buildDiscoverAppBar(context),
      body: CustomScrollView(
        slivers: [
          // CustomAppBar
          // SliverAppBar(
          //   floating: true,
          //   pinned: true,
          //   expandedHeight: 120,
          //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Container(
          //       color: Theme.of(context).scaffoldBackgroundColor,
          //     ),
          //   ),
          //   title: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     child: Row(
          //       children: [
          //         const CircleAvatar(
          //           backgroundImage: AssetImage('assets/images/logo.jpg'),
          //           radius: 20, // Ensure consistent size
          //         ),
          //         const SizedBox(width: 12),
          //         Expanded(
          //           child: GestureDetector(
          //             onTap: () {
          //               _showSearchModal();
          //             },
          //             child: Container(
          //               padding: const EdgeInsets.symmetric(
          //                   horizontal: 16, vertical: 8),
          //               decoration: BoxDecoration(
          //                 color: Colors.grey[100],
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               child: Row(
          //                 children: [
          //                   Icon(Icons.search, color: Colors.grey[600]),
          //                   const SizedBox(width: 8),
          //                   Text(
          //                     overflow: TextOverflow.ellipsis,
          //                     'Explore trends, designers & more',
          //                     style: TextStyle(
          //                         color: Colors.grey[600], fontSize: 12),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // Content
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trending Topics | Will be implemented in next update
                  // AppWidgets.buildSection(
                  //   title: 'Trending Topics',
                  //   child: SizedBox(
                  //     height: 40,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       padding: const EdgeInsets.symmetric(horizontal: 16),
                  //       itemCount: _trendingTopics.length,
                  //       itemBuilder: (context, index) {
                  //         return Container(
                  //           margin: const EdgeInsets.only(right: 8),
                  //           child: Chip(
                  //             label: Text(_trendingTopics[index]),
                  //             backgroundColor: const Color(0xFF6C5CE7),
                  //             labelStyle: const TextStyle(color: Colors.white),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),

                  // Featured Designers
                  AppWidgets.buildSection(
                    title: 'Featured Designers',
                    action: 'View All',
                    onActionTap: () {
                      // Navigate to all designers
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllPage(
                                  key: ValueKey('designers'),
                                  title: 'Featured Designers',
                                  collection: 'designers',
                                )),
                      );
                    },
                    child: SizedBox(
                      height: 200,
                      child: StreamBuilder<List<DiscoverModel>>(
                        stream: AppModel().fetchDesigners(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error fetching collections.'),
                            );
                          } else if (snapshot.hasData) {
                            List<DiscoverModel> designers = snapshot.data!;
                            if (designers.isEmpty) {
                              return const Center(
                                child: Text('No designers available.'),
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: designers.length,
                              itemBuilder: (context, index) {
                                final designer = designers[index];
                                return AppWidgets.buildDesignerCard(
                                  name: designer.title,
                                  specialty: designer.speciality,
                                  imageUrl: designer.thumbnail,
                                  onTap: () {
                                    // Navigate to designer details
                                    AppModel()
                                        .handleDiscoverTap(context, designer);
                                  },
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No data available.'),
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  // Trending Collections
                  AppWidgets.buildSection(
                    title: 'Trending Collections',
                    action: 'See More',
                    onActionTap: () {
                      // Navigate to all collections
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllPage(
                                  key: ValueKey('collections'),
                                  title: 'Trending Collections',
                                  collection: 'collections',
                                )),
                      );
                    },
                    child: SizedBox(
                      height: 280,
                      child: StreamBuilder<List<DiscoverModel>>(
                        stream: AppModel().fetchCollections(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            debugPrint(snapshot.error.toString());
                            return const Center(
                              child: Text(
                                  'Error fetching collections from server.'),
                            );
                          } else if (snapshot.hasData) {
                            List<DiscoverModel> collections = snapshot.data!;
                            if (collections.isEmpty) {
                              return const Center(
                                child: Text('No collections available.'),
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: collections.length,
                              itemBuilder: (context, index) {
                                final collection = collections[index];
                                return AppWidgets.buildCollectionCard(
                                  title: collection
                                      .title, // Replace with the actual property
                                  designer: collection.designer,
                                  imageUrl: collection.thumbnail,
                                  onTap: () {
                                    // Navigate to collection details
                                    AppModel()
                                        .handleDiscoverTap(context, collection);
                                  },
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No data available.'),
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  // Latest Innovations
                  AppWidgets.buildSection(
                    title: 'Latest Innovations',
                    child: SizedBox(
                      height: 200,
                      child: StreamBuilder<List<DiscoverModel>>(
                        stream: AppModel().fetchInnovations(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error fetching collections.'),
                            );
                          } else if (snapshot.hasData) {
                            List<DiscoverModel> innovations = snapshot.data!;
                            if (innovations.isEmpty) {
                              return const Center(
                                child: Text('No innovations available.'),
                              );
                            }
                            return MasonryGridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              itemCount: innovations.length,
                              itemBuilder: (context, index) {
                                final innovation = innovations[index];
                                return AppWidgets.buildInnovationCard(
                                    title: innovation.title,
                                    category: innovation.category,
                                    imageUrl: innovation.thumbnail,
                                    onTap: () {
                                      AppModel().handleDiscoverTap(
                                          context, innovation);
                                    });
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No data available.'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Upcoming Events
                  AppWidgets.buildSection(
                    title: 'Upcoming Events',
                    action: 'View Calendar',
                    onActionTap: () {
                      // Navigate to all events
                      Navigator.pushNamed(context, '/allEvents');
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: StreamBuilder<List<EventModel>>(
                        stream: AppModel().fetchUpcomingEvents(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error fetching events.'),
                            );
                          } else if (snapshot.hasData) {
                            List<EventModel> events = snapshot.data!;
                            if (events.isEmpty) {
                              return const Center(
                                child: Text('No events available.'),
                              );
                            }

                            // **Fix: Wrap ListView.builder with SizedBox**
                            return SizedBox(
                              height:
                                  150, // Set a fixed height for the ListView
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  final event = events[index];
                                  return AppWidgets.buildDiscoverEventCard(
                                    title: event.title,
                                    date: TextHelper.formatDate(event.date),
                                    location: event.location ??
                                        'No location specified',
                                    onTap: () {
                                      // Navigate to event details
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EventDetailsPage(
                                            data: event,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text('No data available.'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Community Highlights
                  /// This feature is hidden for next update
                  // AppWidgets.buildSection(
                  //   title: 'CommunityHighlights',
                  //   child: SizedBox(
                  //     height: 200,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       padding: const EdgeInsets.symmetric(horizontal: 16),
                  //       itemCount: 5,
                  //       itemBuilder: (context, index) {
                  //         return AppWidgets.buildCommunityCard(
                  //           title: 'Sustainable FashionInitiative',
                  //           members: '1.2k members',
                  //           imageUrl: 'assets/images/placeholder.png',
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
