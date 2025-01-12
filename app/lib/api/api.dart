import 'package:app/models/post_model.dart';
import 'package:app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final String _baseUrl = 'http://192.168.1.14:3001';

  Future<User> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/users/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return User.fromJson(jsonData);
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  Future<List<Post>> getPosts() async{
    final url = Uri.parse('$_baseUrl/posts');
    try{
      final response = await http.get(url);

      if (response.statusCode == 200){
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((post) => Post.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error trying get posts: $e');
    }
  }

  Future addPost(Post p) async{
    final url = Uri.parse('$_baseUrl/posts');
    try{
      final postJson = p.toJson();
      final response = await http.post(url, headers: {'Content-Type': 'application/json',}, body: json.encode(postJson));

      if (response.statusCode == 201){
        final jsonData = json.decode(response.body);
        return Post.fromJson(jsonData);
      } else {
        throw Exception('Failed to add post: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error trying to add post: $e');
    }
  }

  Future<User> getUser(String? id) async{
    final url = Uri.parse('$_baseUrl/users/$id');
    try{
      final response = await http.get(url);

      if (response.statusCode == 200){
        final jsonData = json.decode(response.body);
        return User.fromJson(jsonData);
      } else {
        throw Exception('Failed to get user: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error trying get user: $e');
    }
  }

  Future<List<Post>> getUserPosts(String? id) async{
    final url = Uri.parse('$_baseUrl/users/posts/$id');
    try{
      final response = await http.get(url);

      if (response.statusCode == 200){
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((post) => Post.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load user posts: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error trying get user posts: $e');
    }
  }
}
