import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BannerNotifier extends StateNotifier<List<String>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  BannerNotifier() : super([]);

  // Fetching image URLs from Firestore
  Future<void> fetchImages() async {
    try {
      final snapshot = await _firestore
          .collection('banners')
          .doc('all')
          .collection('gallery')
          .get();

      // Map the snapshot data to image URLs
      List<String> fetchedUrls = snapshot.docs
          .map((doc) => doc['imageUrl'] as String) // Ensure 'imageUrl' exists
          .toList();

      state = fetchedUrls;
    } catch (e) {
      debugPrint("Error fetching images: $e");
      // In case of an error, you could set the state to an empty list or show a message
      state = [];
    }
  }
}

// Define the provider
final bannerProvider = StateNotifierProvider<BannerNotifier, List<String>>(
  (ref) => BannerNotifier(),
);
