import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/image_model.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final DateTime date;
  final List<ImageModel> images;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.date,
    required this.images,
  });

  // Factory method to create an Event from Firestore document
  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Event(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      images: [],
    );
  }

  // Copy with method for immutability
  Event copyWith({
    List<ImageModel>? images,
  }) {
    return Event(
      id: id,
      title: title,
      description: description,
      thumbnail: thumbnail,
      date: date,
      images: images ?? this.images,
    );
  }
}

// class Event {
//   final String id;
//   final String title;
//   final String description;
//   final String thumbnail;
//   final DateTime date;
//   final List<Image> images;

//   Event({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.thumbnail,
//     required this.date,
//     required this.images,
//   });

//   // Factory method to create an Event from Firestore document
//   factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
//     final data = doc.data()!;
//     return Event(
//       id: doc.id,
//       title: data['title'] ?? '',
//       description: data['description'] ?? '',
//       thumbnail: data['thumbnail'] ?? '',
//       date: (data['date'] as Timestamp).toDate(),
//       images: [], // Populate later from subcollection
//     );
//   }
// }
