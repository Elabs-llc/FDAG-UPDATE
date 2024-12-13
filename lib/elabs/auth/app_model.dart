import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/event_model.dart';
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
}
