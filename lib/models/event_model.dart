import 'package:fdag/models/poster_data.dart';

/// A model class representing an event with various attributes.v A
class EventModel implements PosterData {
  /// Unique identifier for the event.
  final String id;

  /// Title of the event. This field is required.
  @override
  final String title;

  /// Description of the event. This field is required.
  final String desc;

  /// URL of the image representing the event. This field is required.
  @override
  final String imageUrl;

  final String? eventBanner;

  /// Date of the event. This field is required.
  final String date;

  /// Time of the event. Optional field.
  final String? time;

  /// Location of the event. Optional field.
  final String? location;

  /// Link associated with the event (e.g., registration or details). Optional field.
  final String? link;

  /// Status of the event (e.g., upcoming, past). Optional field.
  final String? status;

  /// Type of the event (e.g., virtual, in-person). Optional field.
  final String? type;

  /// Category of the event. This field is required.
  final String? category;

  /// Events video link
  final String? videoLink;

  /// Creator of the event. This field is required.
  final String createdBy;

  /// The date the event was created. Optional field.
  final String? createdOn;

  /// The user who last updated the event. Optional field.
  final String? updatedBy;

  /// The date the event was last updated. Optional field.
  final String? updatedOn;

  /// The user who deleted the event (if applicable). Optional field.
  final String? deletedBy;

  /// The date the event was deleted (if applicable). Optional field.
  final String? deletedOn;

  /// Constructor for the [EventModel] class. Required fields include [id],
  /// [title], [desc], [imageUrl], [date], [category], and [createdBy].
  EventModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.imageUrl,
    this.eventBanner,
    required this.date,
    this.time,
    this.location,
    this.link,
    this.status,
    this.type,
    this.category,
    this.videoLink,
    required this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.deletedBy,
    this.deletedOn,
  });

  /// Converts the [EventModel] instance to a Map for storage or transmission.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'imageUrl': imageUrl,
      'eventBanner': eventBanner,
      'date': date,
      'time': time,
      'location': location,
      'link': link,
      'status': status,
      'type': type,
      'category': category,
      'videoLink': videoLink,
      'createdBy': createdBy,
      'createdOn': createdOn,
      'updatedBy': updatedBy,
      'updatedOn': updatedOn,
      'deletedBy': deletedBy,
      'deletedOn': deletedOn,
    };
  }

  // Factory constructor to create EventModel from Firestore document data
  factory EventModel.fromDocument(Map<String, dynamic> data) {
    return EventModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      desc: data['desc'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      eventBanner: data['eventBanner'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      location: data['location'] ?? '',
      link: data['link'] ?? '',
      status: data['status'] ?? '',
      type: data['type'] ?? '',
      category: data['category'] ?? '',
      videoLink: data['videoLink'] ?? '',
      createdBy: data['createdBy'] ?? '',
      createdOn: data['createdOn'] ?? '',
      updatedBy: data['updatedBy'] ?? '',
      updatedOn: data['updatedOn'] ?? '',
      deletedBy: data['deletedBy'] ?? '',
      deletedOn: data['deletedOn'] ?? '',
    );
  }
}
