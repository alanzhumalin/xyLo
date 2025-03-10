import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  final String id;
  final String title;
  final bool isAnonymous;
  final String image;
  final DateTime createdAt;
  final String usedId;
  PostModel({
    required this.createdAt,
    required this.usedId,
    required this.id,
    required this.title,
    required this.isAnonymous,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'is_anonymous': isAnonymous,
      'image': image,
      'user_id': usedId
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      title: map['title'] as String,
      isAnonymous: map['is_anonymous'] as bool,
      image: map['image'] as String,
      usedId: map['user_id'] as String,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
