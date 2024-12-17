import 'package:cloud_firestore/cloud_firestore.dart';

class Founder {
  final String id;
  final String name;
  final String bio;
  final String image;

  Founder({
    required this.id,
    required this.name,
    required this.bio,
    required this.image,
  });

  // Factory method to create a Founder from Firestore document
  factory Founder.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Founder(
      id: doc.id,
      name: data['name'] ?? '',
      bio: data['bio'] ?? '',
      image: data['image'] ?? '',
    );
  }
}
