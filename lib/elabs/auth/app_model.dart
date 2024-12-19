import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/discover_model.dart';
import 'package:fdag/models/event.dart';
import 'package:fdag/models/event_model.dart';
import 'package:fdag/models/founder.dart';
import 'package:fdag/models/gallery_model.dart';
import 'package:fdag/models/image_model.dart';
import 'package:fdag/models/show.dart';
import 'package:fdag/models/spotlight_model.dart';
import 'package:fdag/pages/screens/gallery_details_page.dart';
import 'package:fdag/utils/helpers/text_helper.dart';
import 'package:fdag/utils/helpers/ui_helper.dart';
import 'package:fdag/utils/logging/logger.dart';
import 'package:flutter/material.dart';

class AppModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch Welcome messages
  Future<Map<String, dynamic>?> fetchWelcomeMessages() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('messages').doc('welcome').get();
      return documentSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      Logger.error('Error fetching welcome messages: $e');
      return null;
    }
  }

  /// Fetch chair person's message
  Stream<Map<String, dynamic>?> fetchChairpersonMessage() {
    try {
      return _firestore
          .collection('messages')
          .doc('chairperson')
          .snapshots()
          .map((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return documentSnapshot.data() as Map<String, dynamic>;
        } else {
          return null; // Handle cases where the document does not exist
        }
      });
    } catch (e) {
      Logger.error('Error fetching chairperson message: $e');
      return const Stream.empty(); // Return an empty stream on error
    }
  }

  /// Fetching upcoming events as a real-time stream
  Stream<List<EventModel>> fetchUpcomingEvents() {
    try {
      return _firestore
          .collection('events')
          .where('status', isEqualTo: 'upcoming')
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => EventModel.fromDocument(doc.data()))
              .toList());
    } catch (e) {
      Logger.error('Error fetching upcoming events: $e');
      // Return an empty stream in case of error
      return Stream.value([]);
    }
  }

  /// Fetching completed events as a real-time stream
  Stream<List<EventModel>> fetchCompletedEvents() {
    try {
      return _firestore
          .collection('events')
          .where('status', isEqualTo: 'completed')
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => EventModel.fromDocument(doc.data()))
              .toList());
    } catch (e) {
      Logger.error('Error fetching completed events: $e');
      // Return an empty stream in case of error
      return Stream.value([]);
    }
  }

  /// Fetching recents news or announcement for the association as a real-time stream
  Stream<List<EventModel>> fetchNewsUpdates() {
    try {
      return _firestore.collection('newsUpdate').snapshots().map(
            (querySnapshot) => querySnapshot.docs.map((doc) {
              final data = doc.data();
              return EventModel.fromDocument(data);
            }).toList(),
          );
    } catch (e) {
      Logger.error('Error fetching news updates: $e');
      // Return an empty stream in case of error
      return Stream.value([]);
    }
  }

  /// Fetching spotlights
  Stream<List<SpotlightModel>> fetchSpotlights() {
    try {
      return _firestore.collection('spotlights').snapshots().map(
            (querySnapshot) => querySnapshot.docs.map((doc) {
              final data = doc.data();
              return SpotlightModel.fromDocument(data);
            }).toList(),
          );
    } catch (e) {
      Logger.error('Error fetching spotlights: $e');
      // Return an empty stream in case of error
      return Stream.value([]);
    }
  }

  Stream<List<Map<String, dynamic>>> fetchEvents(
      String collection, String? category) {
    Query query = _firestore.collection(collection);
    if (category != null && category != 'All') {
      query = query.where('category', isEqualTo: category);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<Map<String, String>> fetchAuthorDetails(String authorId) async {
    try {
      DocumentSnapshot authorSnapshot =
          await _firestore.collection('authors').doc(authorId).get();
      if (authorSnapshot.exists) {
        var data = authorSnapshot.data() as Map<String, dynamic>;
        return {
          'name': data['name'] ?? 'Unknown Author',
          'profilePic': data['profilePic'] ?? '',
        };
      }
    } catch (e) {
      debugPrint("Error fetching author details: $e");
    }
    return {'name': 'FDAG', 'profilePic': ''};
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('category').get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      debugPrint("Error fetching categories: $e");
      return [];
    }
  }

  Future<String> getCategoryNameById(String categoryId) async {
    try {
      // Query to find the category by its ID
      QuerySnapshot snapshot = await _firestore
          .collection('category')
          .where('id',
              isEqualTo:
                  categoryId) // Assuming 'id' is the field storing category ID
          .limit(1) // Limit to 1 result since category IDs should be unique
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Fetch the first document (there should be only one)
        var category = snapshot.docs[0];
        return category['title'] ??
            ''; // Assuming 'title' is the field for category title
      } else {
        return ''; // No category found for the provided ID
      }
    } catch (e) {
      debugPrint("Error fetching category: $e");
      return '';
    }
  }

  Future<String> getAuthorNameById(String authorId) async {
    try {
      // Query to find the category by its ID
      QuerySnapshot snapshot = await _firestore
          .collection('authors')
          .where('id',
              isEqualTo:
                  authorId) // Assuming 'id' is the field storing author ID
          .limit(1) // Limit to 1 result since category IDs should be unique
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Fetch the first document (there should be only one)
        var category = snapshot.docs[0];
        return category['name'] ?? '';
      } else {
        return ''; // No category found for the provided ID
      }
    } catch (e) {
      debugPrint("Error fetching category: $e");
      return '';
    }
  }

  Future<String> getAuthorImageById(String authorId) async {
    try {
      // Query to find the category by its ID
      QuerySnapshot snapshot = await _firestore
          .collection('authors')
          .where('id',
              isEqualTo:
                  authorId) // Assuming 'id' is the field storing author ID
          .limit(1) // Limit to 1 result since category IDs should be unique
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Fetch the first document (there should be only one)
        var category = snapshot.docs[0];
        return category['profilePic'] ?? '';
      } else {
        return ''; // No category found for the provided ID
      }
    } catch (e) {
      debugPrint("Error fetching category: $e");
      return '';
    }
  }

  /// Fetch a single gallery document by ID
  // Future<GalleryModel> getGallery(String galleryId) async {
  //   final doc = await _firestore.collection('gallery').doc(galleryId).get();
  //   final gallery = GalleryModel.fromFirestore(doc);

  //   // Fetch subcollections for the gallery
  //   gallery.founders = await getFounders(galleryId);
  //   gallery.events = await getEvents(galleryId);
  //   gallery.shows = await getShows(galleryId);

  //   return gallery;
  // }

  // /// Fetch all founders for a specific gallery
  // Future<List<Founder>> getFounders(String galleryId) async {
  //   final querySnapshot = await _firestore
  //       .collection('gallery')
  //       .doc(galleryId)
  //       .collection('founders')
  //       .get();

  //   return querySnapshot.docs.map((doc) => Founder.fromFirestore(doc)).toList();
  // }

  // /// Fetch all events for a specific gallery
  // Future<List<Event>> getEvents(String galleryId) async {
  //   final querySnapshot = await _firestore
  //       .collection('gallery')
  //       .doc(galleryId)
  //       .collection('events')
  //       .get();

  //   // Populate images for each event
  //   final events = await Future.wait(querySnapshot.docs.map((doc) async {
  //     Event event = Event.fromFirestore(doc);

  //     // Fetch images for the event
  //     final images = await getImages(galleryId, 'events', event.id);

  //     // Return a new Event with updated images
  //     return event.copyWith(images: images);
  //   }));

  //   return events;
  // }

  // /// Fetch all shows for a specific gallery
  // Future<List<Show>> getShows(String galleryId) async {
  //   final querySnapshot = await _firestore
  //       .collection('gallery')
  //       .doc(galleryId)
  //       .collection('shows')
  //       .get();

  //   // Populate images for each show
  //   final shows = await Future.wait(querySnapshot.docs.map((doc) async {
  //     Show show = Show.fromFirestore(doc);

  //     // Fetch images for the show
  //     final images = await getImages(galleryId, 'shows', show.id);

  //     // Return a new Show with updated images
  //     return show.copyWith(images: images);
  //   }));

  //   return shows;
  // }

  // /// Fetch all images for a specific event or show
  // Future<List<ImageModel>> getImages(
  //     String galleryId, String subcollection, String documentId) async {
  //   final querySnapshot = await _firestore
  //       .collection('gallery')
  //       .doc(galleryId)
  //       .collection(subcollection)
  //       .doc(documentId)
  //       .collection('images')
  //       .get();

  //   return querySnapshot.docs
  //       .map((doc) => ImageModel.fromFirestore(doc))
  //       .toList();
  // }

  /// Fetch a single gallery document
  Future<GalleryModel> getGallery() async {
    // Fetch the 'all' document from the gallery collection
    final doc = await _firestore.collection('gallery').doc('all').get();
    final gallery = GalleryModel.fromFirestore(doc);

    // Fetch subcollections for the gallery
    gallery.founders = await getFounders();
    gallery.events = await getEvents();
    gallery.shows = await getShows();

    return gallery;
  }

  /// Fetch all founders for the gallery
  Future<List<Founder>> getFounders() async {
    final querySnapshot = await _firestore
        .collection('gallery')
        .doc('all') // Use 'all' document
        .collection('founders')
        .get();

    return querySnapshot.docs.map((doc) => Founder.fromFirestore(doc)).toList();
  }

  /// Fetch all events for the gallery
  Future<List<Event>> getEvents() async {
    final querySnapshot = await _firestore
        .collection('gallery')
        .doc('all') // Use 'all' document
        .collection('events')
        .get();

    // Populate images for each event
    final events = await Future.wait(querySnapshot.docs.map((doc) async {
      Event event = Event.fromFirestore(doc);

      // Fetch images for the event
      final images = await getImages('events', event.id);

      // Return a new Event with updated images
      return event.copyWith(images: images);
    }));

    return events;
  }

  /// Fetch all shows for the gallery
  Future<List<Show>> getShows() async {
    final querySnapshot = await _firestore
        .collection('gallery')
        .doc('all') // Use 'all' document
        .collection('shows')
        .get();

    // Populate images for each show
    final shows = await Future.wait(querySnapshot.docs.map((doc) async {
      Show show = Show.fromFirestore(doc);

      // Fetch images for the show
      final images = await getImages('shows', show.id);

      // Return a new Show with updated images
      return show.copyWith(images: images);
    }));

    return shows;
  }

  /// Fetch all images for a specific event or show
  Future<List<ImageModel>> getImages(
      String subcollection, String documentId) async {
    final querySnapshot = await _firestore
        .collection('gallery')
        .doc('all')
        .collection(subcollection)
        .doc(documentId)
        .collection('images')
        .get();

    // Debugging the fetched
    debugPrint('Document Sub Collection received: $subcollection');
    debugPrint('Document ID received: $documentId');
    debugPrint('Number of images fetched: ${querySnapshot.docs.length}');
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      debugPrint('Fetched image data: $data');
    }

    return querySnapshot.docs
        .map((doc) => ImageModel.fromFirestore(doc))
        .toList();
  }

  /// Fetch Welcome messages
  Future<Map<String, dynamic>?> fetchCompanyInfo() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('company').doc('brand').get();
      return documentSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      Logger.error('Error fetching company info: $e');
      return null;
    }
  }

  /// Fetch all images for a specific discover types
  Future<List<ImageModel>> getDiscoverImages(
      String subcollection, String documentId) async {
    final querySnapshot = await _firestore
        .collection('posts')
        .doc('all')
        .collection(subcollection)
        .doc(documentId)
        .collection('images')
        .get();

    // Debugging the fetched
    debugPrint('Document Sub Collection received: $subcollection');
    debugPrint('Document ID received: $documentId');
    debugPrint('Number of images fetched: ${querySnapshot.docs.length}');
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      debugPrint('Fetched image data: $data');
    }

    return querySnapshot.docs
        .map((doc) => ImageModel.fromFirestore(doc))
        .toList();
  }

  /// Fetching recents collections of the association as a real-time stream
  Stream<List<DiscoverModel>> fetchCollections() {
    try {
      return _firestore
          .collection('posts')
          .doc('all')
          .collection('collections')
          .snapshots()
          .map(
            (querySnapshot) => querySnapshot.docs.map((doc) {
              debugPrint('Document ID: ${doc.id}');
              return DiscoverModel.fromDoc(doc); // Pass the entire document
            }).toList(),
          );
    } catch (e) {
      Logger.error('Error fetching collections: $e');
      debugPrint('Error fetching collections: $e');
      return Stream.value([]);
    }
  }

  /// Fetching recents designers of the association as a real-time stream
  Stream<List<DiscoverModel>> fetchDesigners() {
    try {
      return _firestore
          .collection('posts')
          .doc('all')
          .collection('designers')
          .snapshots()
          .map(
            (querySnapshot) => querySnapshot.docs.map((doc) {
              return DiscoverModel.fromDoc(doc); // Pass the entire document
            }).toList(),
          );
    } catch (e) {
      Logger.error('Error fetching designers: $e');
      return Stream.value([]);
    }
  }

  /// Fetching recents innovations of the association as a real-time stream
  Stream<List<DiscoverModel>> fetchInnovations() {
    try {
      return _firestore
          .collection('posts')
          .doc('all')
          .collection('innovations')
          .snapshots()
          .map(
            (querySnapshot) => querySnapshot.docs.map((doc) {
              return DiscoverModel.fromDoc(doc); // Pass the entire document
            }).toList(),
          );
    } catch (e) {
      Logger.error('Error fetching innovations: $e');
      return Stream.value([]);
    }
  }

  Future<void> handleDiscoverTap(
      BuildContext context, DiscoverModel collection) async {
    try {
      // Fetch images for the specific document (gallery item)
      final images = await getDiscoverImages(
        collection.subcollection,
        collection.id,
      );

      // Convert ImageModel to a list of URLs
      List<String> imageUrls = images.map((img) => img.url).toList();

      // Navigate to the GalleryDetailsPage with the fetched images
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GalleryDetailsPage(
            images: imageUrls,
            title: collection.title,
            date: TextHelper.formatDate(
                TextHelper.formatDateTime(collection.date)),
            description: collection.description,
            category: collection.category,
          ),
        ),
      );
    } catch (e) {
      // Handle errors (e.g., network issues, Firestore errors)
      UiHelper.showSnackBar(
        context,
        'Failed to load images: $e',
        type: SnackBarType.error,
      );
    }
  }
}
