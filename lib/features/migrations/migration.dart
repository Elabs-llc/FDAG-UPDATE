import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class Migration {
  static Future<void> migrateGalleryStructure() async {
    final firestore = FirebaseFirestore.instance;

    // Fetch all current gallery documents
    final gallerySnapshot = await firestore.collection('gallery').get();

    final batch = firestore.batch();

    for (var doc in gallerySnapshot.docs) {
      final galleryId = doc.id;

      // Migrate subcollections like 'founders', 'events', 'shows'
      for (var subCollection in ['founders', 'events', 'shows']) {
        final subCollectionSnapshot = await firestore
            .collection('gallery')
            .doc(galleryId)
            .collection(subCollection)
            .get();

        for (var subDoc in subCollectionSnapshot.docs) {
          // Add to new structure under 'all'
          batch.set(
            firestore
                .collection('gallery')
                .doc('all')
                .collection(subCollection)
                .doc(subDoc.id),
            subDoc.data(),
          );
        }
      }

      // Optionally, delete old documents to clean up
      // batch.delete(firestore.collection('gallery').doc(galleryId));
    }

    // Commit the batch
    await batch.commit();
    debugPrint('Migration complete!');
  }
}
