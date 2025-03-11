import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentsModel {
  final String id;
  final String userId;
  final String postId;
  final String text;
  final DateTime createdAt;
  final String? username;
  final String? avatar;

  CommentsModel(
      {required this.id,
      required this.userId,
      required this.postId,
      required this.text,
      required this.createdAt,
      this.avatar,
      this.username});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'post_id': postId,
      'text': text,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory CommentsModel.fromMap(Map<String, dynamic> map) {
    return CommentsModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      postId: map['post_id'] as String,
      text: map['text'] as String,
      createdAt: DateTime.parse(map['created_at']),
      username: map['username'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentsModel.fromJson(String source) =>
      CommentsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
