import 'dart:async';

import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:fdag/utils/providers/banner_notifier.dart';
import 'package:fdag/utils/providers/gallery_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Gallery extends ConsumerStatefulWidget {
  const Gallery({super.key});

  @override
  ConsumerState<Gallery> createState() => _GalleryState();
}

class _GalleryState extends ConsumerState<Gallery>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();

    // Fetch images from Firestore
    ref.read(bannerProvider.notifier).fetchImages();

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged); // Listen for tab changes
    _fetchGalleryForTab(0); // Fetch data for the initial tab
  }

  void _startImageRotation() {
    _timer = Timer.periodic(Duration(seconds: 20), (timer) {
      setState(() {
        // Check if bannerProvider is not empty before updating the index
        final bannerCount = ref.read(bannerProvider).length;
        if (bannerCount > 0) {
          currentImageIndex = (currentImageIndex + 1) % bannerCount;
        }
      });
    });
  }

  void _fetchGalleryForTab(int index) {
    final categories = ['all', 'founders', 'events', 'shows'];
    final selectedCategory = categories[index];
    ref.read(galleryProvider.notifier).fetchGallery(selectedCategory);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging || _tabController.index != null) {
      _fetchGalleryForTab(_tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final galleryData =
        ref.watch(galleryProvider); // Listen to provider changes

    final bannerImages = ref.watch(bannerProvider);

    if (bannerImages.isNotEmpty && currentImageIndex == 0) {
      _startImageRotation(); // Start rotating images only when they are available
    }

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: const Color.fromARGB(55, 15, 14, 17),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: bannerImages.isNotEmpty
                          ? Image.network(
                              bannerImages[currentImageIndex],
                              key: ValueKey<String>(bannerImages[
                                  currentImageIndex]), // Use image URL as key
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/placeholder.png',
                              key: ValueKey<int>(
                                  currentImageIndex), // Use unique key for placeholder
                              fit: BoxFit.cover,
                            ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color.fromARGB(255, 240, 236, 236)
                                .withAlpha(2),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Capturing moments in fashion',
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Founding Members'),
                  Tab(text: 'Events'),
                  Tab(text: 'Fashion Shows'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildGalleryTab('all', galleryData),
            _buildFoundingMembers('founders', galleryData),
            _buildEventsGallery('events', galleryData),
            _buildFashionShows('shows', galleryData),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C5CE7),
        onPressed: _showFilterBottomSheet,
        child: Icon(Icons.filter_list),
      ),
    );
  }

  Widget _buildGalleryTab(String category, List<Map<String, dynamic>> data) {
    return RefreshIndicator(
      onRefresh: () async {
        _fetchGalleryForTab(
            _tabController.index); // Refresh data for active tab
      },
      child: data.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading spinner if data is empty
          : MasonryGridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return AppWidgets.buildGalleryItem(
                  imageUrl: item['thumbnail'],
                  title: item['title'],
                  date: item['date'],
                  height: index.isEven ? 280 : 200,
                  onTap: () {
                    // Add your image detail navigation logic here
                  },
                );
              },
            ),
    );
  }

  Widget _buildFoundingMembers(
      String category, List<Map<String, dynamic>> data) {
    return RefreshIndicator(
      onRefresh: () async {
        _fetchGalleryForTab(
            _tabController.index); // Refresh data for active tab
      },
      child: data.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading spinner if data is empty
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Founding Year Section
                Text(
                  'Established 2024',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 20),
                // Founding Members Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];

                    return AppWidgets.buildFounderCard(
                      name: item['title'] ?? 'FDAG',
                      role: item['role'] ?? 'NA',
                      imageUrl:
                          item['thumbnail'] ?? 'assets/images/placeholder.png',
                    );
                  },
                ),
              ],
            ),
    );
  }

  Widget _buildEventsGallery(String category, List<Map<String, dynamic>> data) {
    return RefreshIndicator(
      onRefresh: () async {
        _fetchGalleryForTab(
            _tabController.index); // Refresh data for active tab
      },
      child: data.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading spinner if data is empty
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return AppWidgets.buildEventCard(
                  title: item['title'],
                  date: item['date'],
                  location: item['location'],
                  imageUrl: item['thumbnail'],
                );
              },
            ),
    );
  }

  Widget _buildFashionShows(String category, List<Map<String, dynamic>> data) {
    return RefreshIndicator(
      onRefresh: () async {
        _fetchGalleryForTab(
            _tabController.index); // Refresh data for active tab
      },
      child: data.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading spinner if data is empty
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return AppWidgets.buildFashionShowCard(
                  title: item['title'],
                  year: item['year'],
                  imageUrl: item['thumbnail'],
                );
              },
            ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Filter Gallery',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Add your filter options here
            ],
          ),
        );
      },
    );
  }
}
