import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  final String id;
  final String title;
  final bool isAnonymous;
  final String image;
  final DateTime createdAt;
  final String userId;
  final String userName;
  final String userAvatar;
  final int? likeCount;
  final int? commentCount;
  bool? isLiked;
  PostModel(
      {required this.createdAt,
      required this.userId,
      required this.id,
      required this.title,
      required this.isAnonymous,
      required this.image,
      required this.userAvatar,
      required this.userName,
      this.commentCount,
      this.likeCount,
      this.isLiked});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'is_anonymous': isAnonymous,
      'image': image,
      'user_id': userId,
      'username': userName,
      'avatar': userAvatar
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        id: map['id'] as String,
        title: map['title'] as String,
        isAnonymous: map['is_anonymous'] as bool,
        image: map['image'] as String,
        userId: map['user_id'] as String,
        createdAt: DateTime.parse(map['created_at']),
        userName: map['username'] as String,
        userAvatar: map['avatar'] as String,
        commentCount: map['comment_count'] as int? ?? 0,
        likeCount: map['like_count'] as int? ?? 0,
        isLiked: map['is_liked'] as bool);
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PostModel copyWith({
    String? id,
    String? title,
    bool? isAnonymous,
    String? image,
    DateTime? createdAt,
    String? userId,
    String? userName,
    String? userAvatar,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
