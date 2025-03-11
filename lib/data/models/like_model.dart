import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LikeModel {
  final String id;
  final DateTime createdAt;
  final String postId;
  final String userId;
  LikeModel({
    required this.id,
    required this.createdAt,
    required this.postId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'post_id': postId,
      'user_id': userId,
    };
  }

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at']),
      postId: map['post_id'] as String,
      userId: map['user_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LikeModel.fromJson(String source) =>
      LikeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
