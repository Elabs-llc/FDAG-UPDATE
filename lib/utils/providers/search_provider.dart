import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<SearchModel>>((ref) async {
  final searchQuery = ref.watch(searchQueryProvider);

  if (searchQuery.isEmpty) {
    return [];
  }

  // Analyze the search term to determine the subcollection name
  final subcollectionName = analyzeSearchTerm(searchQuery);

  try {
    // Check if the subcollection exists
    final subcollectionRef = FirebaseFirestore.instance
        .collection('posts')
        .doc('all')
        .collection(subcollectionName);

    final subcollectionExists =
        await checkSubcollectionExists(subcollectionRef);

    if (subcollectionExists) {
      // Query the relevant subcollection
      final snapshot = await subcollectionRef.get();
      return snapshot.docs
          .map((doc) => SearchModel.fromJson(doc.data()))
          .toList();
    } else {
      // Fall back to a default or general collection if no specific match
      final fallbackSnapshot =
          await FirebaseFirestore.instance.collection(subcollectionName).get();

      return fallbackSnapshot.docs
          .map((doc) => SearchModel.fromJson(doc.data()))
          .toList();
    }
  } catch (e) {
    // Handle errors if the subcollection does not exist or other issues occur
    debugPrint('Error fetching search results: $e');
    return [];
  }
});

// Helper function to analyze the search term and map it to a subcollection name
String analyzeSearchTerm(String searchQuery) {
  // For example, you can normalize terms or map them to predefined categories
  final normalizedTerm = searchQuery.toLowerCase().trim();

  if (['design', 'designers', 'design style', 'styler']
      .contains(normalizedTerm)) {
    return 'designers';
  } else if ([
    'styles',
    'shows',
    'collections',
    'ghanaian',
    'ghana',
    'africa',
    'kente'
  ].contains(normalizedTerm)) {
    return 'collections';
  } else if ([
    'events',
    'current events',
    'headlines',
    'upcoming',
    'upcoming events',
    'workshop',
    'fashion shows',
    ''
  ].contains(normalizedTerm)) {
    return 'events';
  } else if (['spotlights', 'upcoming shows', 'awards', 'announcement']
      .contains(normalizedTerm)) {
    return 'spotlights';
  } else if (['trending', 'lastest', 'updates', 'news']
      .contains(normalizedTerm)) {
    return 'newsUpdate';
  }

  // Default to a generic collection if no match is found
  return 'collections';
}

// Helper function to check if a subcollection exists
Future<bool> checkSubcollectionExists(
    CollectionReference<Map<String, dynamic>> subcollectionRef) async {
  try {
    final snapshot = await subcollectionRef.limit(1).get();
    return snapshot.docs.isNotEmpty;
  } catch (e) {
    debugPrint('Error checking subcollection existence: $e');
    return false;
  }
}
