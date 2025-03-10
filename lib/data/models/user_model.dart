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

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
