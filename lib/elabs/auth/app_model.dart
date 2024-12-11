import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/event_model.dart';
import 'package:fdag/utils/logging/logger.dart';

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
  Future<Map<String, dynamic>?> fetchChairpersonMessage() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('messages').doc('chairperson').get();
      return documentSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      Logger.error('Error fetching chairperson message: $e');
      return null;
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
}
