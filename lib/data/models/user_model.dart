import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final String major;
  final String username;
  UserModel({
    required this.id,
    required this.email,
    required this.major,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'major': major,
      'username': username,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      major: map['major'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
