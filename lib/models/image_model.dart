import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  final String id;
  final String url;
  final String caption;
  final DateTime uploadedAt;

  ImageModel({
    required this.id,
    required this.url,
    required this.caption,
    required this.uploadedAt,
  });

  // Factory method to create an ImageModel from Firestore document
  factory ImageModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ImageModel(
      id: doc.id,
      url: data['url'] ?? '',
      caption: data['caption'] ?? '',
      uploadedAt: (data['uploadedAt'] as Timestamp).toDate(),
    );
  }
}
