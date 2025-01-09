class UserPost{
  final String? id;
  final String name;
  final String? avatar;
  
  UserPost({this.id, required this.name, this.avatar = ''});

  factory UserPost.fromJson(Map<String, dynamic> json) {
    return UserPost(
      id: json['_id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}