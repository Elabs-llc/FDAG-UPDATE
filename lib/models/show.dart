import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/image_model.dart';

class Show {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final DateTime date;
  final List<ImageModel> images;

  Show({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.date,
    required this.images,
  });

  // Factory method to create a Show from Firestore document
  factory Show.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Show(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      images: [], // Populate later from subcollection
    );
  }

  // Copy with method for immutability
  Show copyWith({
    List<ImageModel>? images,
  }) {
    return Show(
      id: id,
      title: title,
      description: description,
      thumbnail: thumbnail,
      date: date,
      images: images ?? this.images,
    );
  }
}
