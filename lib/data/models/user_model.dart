// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final String major;
  final String username;
  final String avatar;
  final int postCount;
  final int subscribers;
  final DateTime createdAt;

  UserModel(
      {required this.id,
      required this.email,
      required this.major,
      required this.username,
      required this.avatar,
      required this.createdAt,
      required this.postCount,
      required this.subscribers});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'major': major,
      'username': username,
      'created_at': createdAt.toIso8601String(),
      'avatar': avatar,
      'post_count': postCount,
      'subscribers': subscribers
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] as String,
        email: map['email'] as String,
        major: map['major'] as String,
        username: map['username'] as String,
        createdAt: DateTime.parse(map['created_at']),
        avatar: map['avatar'] as String,
        postCount: map['post_count'] as int,
        subscribers: map['subscribers'] as int);
  }
  UserModel copyWith({
    String? id,
    String? email,
    String? major,
    String? username,
    String? avatar,
    int? postCount,
    int? subscribers,
    DateTime? createdAt,
  }) {
    return UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        major: major ?? this.major,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
        postCount: postCount ?? this.postCount,
        subscribers: subscribers ?? this.subscribers);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
