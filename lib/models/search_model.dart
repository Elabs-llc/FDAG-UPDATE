class SearchModel {
  final String id;
  final String title;
  final String subcollection;
  final String location;
  final String thumbnail;

  SearchModel({
    required this.id,
    required this.title,
    required this.subcollection,
    required this.location,
    required this.thumbnail,
  });

  // Simple fromJson constructor
  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        subcollection: json['subcollection'] ?? '',
        location: json['location'] ?? '',
        thumbnail: json['thumbnail'] ?? '',
      );

  // Simple toJson method
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subcollection': subcollection,
        'location': location,
        'thumbnail': thumbnail,
      };
}