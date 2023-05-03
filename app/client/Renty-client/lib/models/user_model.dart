class UserModel {
  final int id;
  String name;
  String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['user_id'], name: json['name'], email: json['email']);
  }
}
