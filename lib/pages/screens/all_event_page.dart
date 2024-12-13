import 'package:fdag/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fdag/models/event_model.dart';

class AllEventPage extends StatefulWidget {
  const AllEventPage({super.key});

  @override
  State<AllEventPage> createState() => _AllEventPageState();
}

class _AllEventPageState extends State<AllEventPage> {
  final List<String> _filterCategories = ['All']; // Initially only All
  String _selectedCategory = 'All';
  List<Map<String, dynamic>> _categories = []; // List to store categories
  Map<String, String> _categoryTitles = {}; // Map category IDs to titles
  Map<String, Map<String, String>> _authorData = {};

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Fetch categories from Firestore
  }

  // Fetch categories from Firestore
  Future<void> _fetchCategories() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('category').get();
      List<Map<String, dynamic>> categories = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {
          'id': data['id'],
          'title': data['title'],
        };
      }).toList();
      setState(() {
        _categories = categories;
        _filterCategories.addAll(categories.map((e) => e['title'] as String));
        // Populate categoryTitles map to map IDs to titles
        _categoryTitles = {
          for (var category in categories) category['id']: category['title'],
        };
        debugPrint("Categories: $_categories");
      });
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
  }

  // Fetch events based on selected category from Firestore
  Stream<List<EventModel>> _getEvents() {
    Query query = FirebaseFirestore.instance.collection('events');

    if (_selectedCategory != 'All') {
      query = query.where('category', isEqualTo: _selectedCategory);
    }

    return query.snapshots().asyncMap((snapshot) async {
      for (var doc in snapshot.docs) {
        var eventData = doc.data() as Map<String, dynamic>;
        if (eventData['createdBy'] != null) {
          await _fetchAuthorDetails(eventData['createdBy']);
        }
      }
      return snapshot.docs.map((doc) {
        return EventModel.fromDocument(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> _fetchAuthorDetails(String authorId) async {
    if (_authorData.containsKey(authorId)) return; // Skip if already fetched
    try {
      DocumentSnapshot authorSnapshot = await FirebaseFirestore.instance
          .collection('authors')
          .doc(authorId)
          .get();
      if (authorSnapshot.exists) {
        var data = authorSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _authorData[authorId] = {
            'name': data['name'] ?? 'Unknown Author',
            'profilePic': data['profilePic'] ?? '',
          };
        });
      }
    } catch (e) {
      debugPrint("Error fetching author details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildCategoryFilter(),
          // Events List with dynamic length
          StreamBuilder<List<EventModel>>(
            stream: _getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              }

              if (snapshot.hasError) {
                return SliverFillRemaining(
                    child: Center(child: Text('Error: ${snapshot.error}')));
              }
              if (!snapshot.hasData) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              // Check if the data is empty
              if (snapshot.data!.isEmpty) {
                return SliverFillRemaining(
                  child: Center(child: Text("No events available.")),
                );
              }

              return AnimationLimiter(
                child: SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var event = snapshot.data![index];
                        String imageUrl = event.imageUrl;
                        String categoryTitle =
                            _categoryTitles[event.category] ??
                                'Unknown Category';

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withAlpha(50),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        // Navigate to event details
                                        N
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Image Section
                                          Stack(
                                            children: [
                                              FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/images/placeholder.png',
                                                image: imageUrl,
                                                height: 200,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                top: 16,
                                                left: 16,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF6C5CE7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text(
                                                    categoryTitle,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Content Section
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  event.title,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF2D3436),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  event.desc,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 15,
                                                      backgroundImage: (_authorData[
                                                                          event
                                                                              .createdBy]
                                                                      ?[
                                                                      'profilePic']
                                                                  ?.isNotEmpty ??
                                                              false)
                                                          ? NetworkImage(
                                                              _authorData[event
                                                                      .createdBy]![
                                                                  'profilePic']!)
                                                          : AssetImage(
                                                                  'assets/images/placeholder.png')
                                                              as ImageProvider,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _authorData[event
                                                                        .createdBy]
                                                                    ?['name'] ??
                                                                'FDAG',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            'Date:  ${TextHelper.formatDate(event.createdOn ?? '')}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.bookmark_border,
                                                          color: Color(
                                                              0xFF6C5CE7)),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show filter bottom sheet
        },
        backgroundColor: const Color(0xFF6C5CE7),
        child: const Icon(Icons.filter_list),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'News & Updates',
          style: TextStyle(
            color: Color(0xFF2D3436),
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Implement search functionality
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _filterCategories.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_filterCategories[index]),
                selected: _selectedCategory == _filterCategories[index],
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = _filterCategories[index];
                  });
                  debugPrint('Category selected: $_selectedCategory');
                },
                backgroundColor: Colors.grey[100],
                selectedColor: const Color(0xFF6C5CE7),
                labelStyle: TextStyle(
                  color: _selectedCategory == _filterCategories[index]
                      ? Colors.white
                      : Colors.black87,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            );
          },
        ),
      ),
    );
  }
}
