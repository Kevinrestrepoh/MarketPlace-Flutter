import 'package:app/models/userpost_model.dart';

class Post{
  final String? id;
  final String title;
  final String description;
  final double price;
  final List<String>? images;
  final UserPost userId;
  
  Post({this.id, required this.title, required this.description, required this.price, this.images = const[], required this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      images: (json['images'] as List<dynamic>).map((image) => image as String).toList(),
      userId: UserPost.fromJson(json['user_id'])
    );
  }
}