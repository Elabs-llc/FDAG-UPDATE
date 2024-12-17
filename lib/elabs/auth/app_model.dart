import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/event.dart';
import 'package:fdag/models/event_model.dart';
import 'package:fdag/models/founder.dart';
import 'package:fdag/models/gallery_model.dart';
import 'package:fdag/models/image_model.dart';
import 'package:fdag/models/show.dart';
import 'package:fdag/models/spotlight_model.dart';
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
        .doc('all') // Use 'all' document
        .collection(subcollection)
        .doc(documentId)
        .collection('images')
        .get();

    return querySnapshot.docs
        .map((doc) => ImageModel.fromFirestore(doc))
        .toList();
  }
}
