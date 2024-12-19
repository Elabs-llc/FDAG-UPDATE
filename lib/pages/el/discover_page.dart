import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:fdag/elabs/auth/app_model.dart';
import 'package:fdag/models/discover_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final List<String> _trendingTopics = [
    'Sustainable Fashion',
    'Digital Design',
    'Upcoming Designers',
    'Fashion Tech',
    'Local Artisans',
    'Eco Materials',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // CustomAppBar
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.jpg'),
                    radius: 20, // Ensure consistent size
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _showSearchModal();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              'Explore trends, designers & more',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trending Topics
                  AppWidgets.buildSection(
                    title: 'Trending Topics',
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _trendingTopics.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: Chip(
                              label: Text(_trendingTopics[index]),
                              backgroundColor: const Color(0xFF6C5CE7),
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Featured Designers
                  AppWidgets.buildSection(
                    title: 'Featured Designers',
                    action: 'View All',
                    onActionTap: () {
                      // Navigate to all designers
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
                            return const Center(
                              child: Text('Error fetching collections.'),
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
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                child: Text('No collections available.'),
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search trends, designers...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
