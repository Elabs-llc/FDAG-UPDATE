import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/image_model.dart';
import 'package:flutter/material.dart';

class DiscoverModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String designer;
  final String speciality;
  final String category;
  final String subcollection;
  final DateTime? date;
  final List<ImageModel> images;

  DiscoverModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.designer,
    required this.speciality,
    required this.category,
    required this.subcollection,
    this.date,
    required this.images,
  });

  // Factory method to create a DiscoverModel from Firestore document
  factory DiscoverModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    String dateString = data['date'] ?? ''; // Ensure the field exists
    DateTime? parsedDate;

    if (dateString.isNotEmpty) {
      // Parse the date string into a DateTime object
      final dateParts = dateString.split('/');
      if (dateParts.length == 3) {
        parsedDate = DateTime(
          int.parse(dateParts[2]), // Year
          int.parse(dateParts[1]), // Month
          int.parse(dateParts[0]), // Day
        );
      }
    }
    return DiscoverModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      designer: data['designer'] ?? '',
      speciality: data['speciality'] ?? '',
      category: data['category'] ?? '',
      subcollection: data['subcollection'] ?? '',
      date: parsedDate,
      images: [], // Populate later from subcollection
    );
  }

  factory DiscoverModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    debugPrint('DiscoverModel.fromDoc: $doc');
    String dateString = doc['date'] ?? ''; // Ensure the field exists
    DateTime? parsedDate;

    if (dateString.isNotEmpty) {
      // Parse the date string into a DateTime object
      final dateParts = dateString.split('/');
      if (dateParts.length == 3) {
        parsedDate = DateTime(
          int.parse(dateParts[2]), // Year
          int.parse(dateParts[1]), // Month
          int.parse(dateParts[0]), // Day
        );
      }
    }
    return DiscoverModel(
      id: doc.id,
      title: doc['title'] ?? '',
      description: doc['description'] ?? '',
      thumbnail: doc['thumbnail'] ?? '',
      designer: doc['designer'] ?? '',
      speciality: doc['speciality'] ?? '',
      category: doc['category'] ?? '',
      subcollection: doc['subcollection'] ?? '',
      date: parsedDate, // (doc['date'] as Timestamp).toDate(),
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
      subcollection: subcollection,
      date: date,
      images: images ?? this.images,
    );
  }
}
