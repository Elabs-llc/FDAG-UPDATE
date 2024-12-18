import 'package:cloud_firestore/cloud_firestore.dart';

class Founder {
  final String id;
  final String title;
  final String bio;
  final String thumbnail;
  final String role;

  Founder({
    required this.id,
    required this.title,
    required this.bio,
    required this.thumbnail,
    required this.role,
  });

  // Factory method to create a Founder from Firestore document
  factory Founder.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Founder(
      id: doc.id,
      title: data['title'] ?? '',
      bio: data['bio'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      role: data['role'] ?? '',
    );
  }
}
