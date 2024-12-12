import 'package:fdag/models/poster_data.dart';

/// A model class representing a Spotlight entry, which highlights a member, project,
/// or initiative each month to promote engagement.
class SpotlightModel implements PosterData {
  /// Unique identifier for the spotlight entry.
  final String id;

  /// Title of the spotlight (e.g., Member Name, Project Title, or Initiative Name).
  @override
  final String title;

  /// Description of the spotlight entry, providing details about the member,
  /// project, or initiative.
  final String description;

  /// URL of the image associated with the spotlight entry.
  @override
  final String imageUrl;

  /// URL of the video associated with the spotlight entry, if available.
  final String? videoUrl;

  /// Category of the spotlight (e.g., 'Member', 'Project', 'Initiative').
  final String category;

  /// The month and year of the spotlight, formatted as 'MM/YYYY'.
  final String spotlightMonth;

  /// Name of the creator who added this spotlight entry.
  final String createdBy;

  /// The date the spotlight entry was created.
  final String? createdOn;

  /// Name of the last user who updated the spotlight entry.
  final String? updatedBy;

  /// The date the spotlight entry was last updated.
  final String? updatedOn;

  /// Name of the user who deleted the spotlight entry, if applicable.
  final String? deletedBy;

  /// The date the spotlight entry was deleted, if applicable.
  final String? deletedOn;

  /// Constructor for the [SpotlightModel] class.
  SpotlightModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.videoUrl,
    required this.category,
    required this.spotlightMonth,
    required this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.deletedBy,
    this.deletedOn,
  });

  /// Factory constructor to create a [SpotlightModel] instance from Firestore document data.
  factory SpotlightModel.fromDocument(Map<String, dynamic> data) {
    return SpotlightModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      videoUrl: data['videoUrl'],
      category: data['category'] ?? '',
      spotlightMonth: data['spotlightMonth'] ?? '',
      createdBy: data['createdBy'] ?? '',
      createdOn: data['createdOn'],
      updatedBy: data['updatedBy'],
      updatedOn: data['updatedOn'],
      deletedBy: data['deletedBy'],
      deletedOn: data['deletedOn'],
    );
  }

  /// Converts the [SpotlightModel] instance to a Map for storage or transmission.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'category': category,
      'spotlightMonth': spotlightMonth,
      'createdBy': createdBy,
      'createdOn': createdOn,
      'updatedBy': updatedBy,
      'updatedOn': updatedOn,
      'deletedBy': deletedBy,
      'deletedOn': deletedOn,
    };
  }
}
