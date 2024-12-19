import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  DiscoverNotifier() : super([]);

  // Initialize Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch data for a specific category
  Future<void> fetchDiscover(String category) async {
    try {
      List<Map<String, dynamic>> fetchedData = [];

      // Fetch data for a specific category
      final querySnapshot = await _firestore
          .collection('posts')
          .doc('all')
          .collection(category)
          .get();

      fetchedData =
          querySnapshot.docs.map((doc) => _processDocData(doc)).toList();

      // Update the state with fetched data
      state = fetchedData;

      debugPrint("Fetched ${fetchedData.length} items for category: $category");
    } catch (e) {
      debugPrint("Error fetching posts data: $e");
    }
  }

  // Helper method to process document data
  Map<String, dynamic> _processDocData(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return {
      'subcollection':
          data['subcollection'] ?? '', // Provide default subcollection
      'thumbnail': data['thumbnail'] ?? '', // Provide default thumbnail
      'title': data['title'] ?? 'Untitled', // Provide default title
      'designer':
          data['designer'] ?? 'Unknown Designer', // Provide default Designer
      'date': data['date'] ?? 'Unknown Date', // Provide default date
      'id': data['id'] ?? 'Unknown ID', // Provide default ID
      'description': data['description'] ??
          'Unknown Description', // Provide default Description
    };
  }
}

// Define the provider
final discoverProvider =
    StateNotifierProvider<DiscoverNotifier, List<Map<String, dynamic>>>(
  (ref) => DiscoverNotifier(),
);
