import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GalleryNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  GalleryNotifier() : super([]);

  // Initialize Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch data for a specific category
  Future<void> fetchGallery(String category) async {
    try {
      List<Map<String, dynamic>> fetchedData = [];

      if (category == 'all') {
        // Fetch all documents from 'founders', 'events', and 'shows' subcollections
        final foundersSnapshot = await _firestore
            .collection('gallery')
            .doc('all')
            .collection('founders')
            .get();

        final eventsSnapshot = await _firestore
            .collection('gallery')
            .doc('all')
            .collection('events')
            .get();

        final showsSnapshot = await _firestore
            .collection('gallery')
            .doc('all')
            .collection('shows')
            .get();

        // Merge data from all subcollections
        fetchedData.addAll(
            foundersSnapshot.docs.map((doc) => _processDocData(doc)).toList());
        fetchedData.addAll(
            eventsSnapshot.docs.map((doc) => _processDocData(doc)).toList());
        fetchedData.addAll(
            showsSnapshot.docs.map((doc) => _processDocData(doc)).toList());
      } else {
        // Fetch data for a specific category
        final querySnapshot = await _firestore
            .collection('gallery')
            .doc('all')
            .collection(category)
            .get();

        fetchedData =
            querySnapshot.docs.map((doc) => _processDocData(doc)).toList();
      }

      // Update the state with fetched data
      state = fetchedData;

      debugPrint("Fetched ${fetchedData.length} items for category: $category");
    } catch (e) {
      debugPrint("Error fetching gallery data: $e");
    }
  }

  // Helper method to process document data
  Map<String, dynamic> _processDocData(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return {
      'thumbnail': data['thumbnail'] ?? '', // Provide default thumbnail
      'title': data['title'] ?? 'Untitled', // Provide default title
      'date': data['date'] ?? 'Unknown Date', // Provide default date
      'role': data['role'] ?? 'Untitled', // Provide default role
      'location':
          data['location'] ?? 'Unknown Location', // Provide default location
      'year': data['year'] ?? 'Unknown Year', // Provide default location
    };
  }
}

// Define the provider
final galleryProvider =
    StateNotifierProvider<GalleryNotifier, List<Map<String, dynamic>>>(
  (ref) => GalleryNotifier(),
);
