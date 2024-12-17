import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdag/models/event.dart';
import 'package:fdag/models/founder.dart';
import 'package:fdag/models/show.dart';

class GalleryModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final DateTime createdAt;
  late List<Founder> founders;
  late List<Event> events;
  late List<Show> shows;

  GalleryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.createdAt,
    List<Founder>? founders,
    List<Event>? events,
    List<Show>? shows,
  })  : founders = founders ?? [],
        events = events ?? [],
        shows = shows ?? [];

  // Factory method to create a GalleryModel from Firestore document
  factory GalleryModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return GalleryModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
