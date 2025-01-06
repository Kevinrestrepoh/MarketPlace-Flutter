import 'package:app/models/user_model.dart';

class Post{
  final String? id;
  final String title;
  final String description;
  final double price;
  final List<String>? images;
  final Object userId;
  
  Post({this.id, required this.title, required this.description, required this.price, this.images, required this.userId}){
    if (userId is! User && userId is! String){
      throw ArgumentError("user_id not allowed");
    }
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      images: json['images'],
      userId: json['user_id']
    );
  }
}