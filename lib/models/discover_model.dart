import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/image_model.dart';

class DiscoverModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String designer;
  final String speciality;
  final String category;
  final DateTime date;
  final List<ImageModel> images;

  DiscoverModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.designer,
    required this.speciality,
    required this.category,
    required this.date,
    required this.images,
  });

  // Factory method to create a DiscoverModel from Firestore document
  factory DiscoverModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return DiscoverModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      designer: data['designer'] ?? '',
      speciality: data['speciality'] ?? '',
      category: data['category'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      images: [], // Populate later from subcollection
    );
  }

  factory DiscoverModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return DiscoverModel(
      id: doc.id,
      title: doc['title'] ?? '',
      description: doc['description'] ?? '',
      thumbnail: doc['thumbnail'] ?? '',
      designer: doc['designer'] ?? '',
      speciality: doc['speciality'] ?? '',
      category: doc['category'] ?? '',
      date: (doc['date'] as Timestamp).toDate(),
      images: [], // Populate later from subcollection
    );
  }

  // Copy with method for immutability
  DiscoverModel copyWith({
    List<ImageModel>? images,
  }) {
    return DiscoverModel(
      id: id,
      title: title,
      description: description,
      thumbnail: thumbnail,
      designer: designer,
      speciality: speciality,
      category: category,
      date: date,
      images: images ?? this.images,
    );
  }
}
