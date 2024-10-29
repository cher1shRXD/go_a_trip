import 'package:go_a_trip/models/user_model.dart';

class Board {
  final int id;
  final String title;
  final String detail;
  final String createdAt;
  final String category;
  final int likesCount;
  final User author;
  final List<User> likes;

  Board({
    required this.id,
    required this.title,
    required this.detail,
    required this.createdAt,
    required this.category,
    required this.likesCount,
    required this.author,
    required this.likes,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['id'] as int,
      title: json['title'] as String,
      detail: json['detail'] as String,
      createdAt: json['createdAt'] as String,
      category: json['category'] as String,
      likesCount: json['likesCount'] as int,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      likes: json['likes'] as List<User>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'createdAt': createdAt,
      'category': category,
      'likesCount': likesCount,
      'author': author.toJson(),
      'likes': likes,
    };
  }
}
