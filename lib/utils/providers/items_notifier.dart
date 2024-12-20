import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/discover_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 0);
final hasMoreDataProvider = StateProvider<bool>((ref) => true);
final itemsPerPageProvider = Provider<int>((ref) => 20);

final paginatedItemsProvider =
    StateNotifierProvider<ItemsNotifier, List<DiscoverModel>>((ref) {
  return ItemsNotifier();
});

class ItemsNotifier extends StateNotifier<List<DiscoverModel>> {
  ItemsNotifier() : super([]);

  Future<bool> loadMoreItems(int page, int limit,
      {required String collection}) async {
    try {
      final lastItem = state.isNotEmpty ? state.last : null;

      final query = FirebaseFirestore.instance
          .collection('posts')
          .doc('all')
          .collection(collection)
          .orderBy('date')
          .limit(limit);

      final snapshots = lastItem != null
          ? await query.startAfterDocument(lastItem as DocumentSnapshot).get()
          : await query.get();

      final newItems =
          snapshots.docs.map((doc) => DiscoverModel.fromDoc(doc)).toList();

      state = [...state, ...newItems];

      return newItems.length == limit;
    } catch (e) {
      debugPrint('Error loading items: $e');
      return false;
    }
  }

  void reset() {
    state = [];
  }
}
