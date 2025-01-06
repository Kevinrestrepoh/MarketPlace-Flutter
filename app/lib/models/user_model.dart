class User{
  final String? id;
  final String name;
  final String email;
  final int phone;
  final String? avatar;
  
  User({this.id, required this.name, required this.email, required this.phone, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }
}