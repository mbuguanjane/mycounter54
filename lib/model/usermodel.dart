class UserModel {
  final int id;
  final String name;
  final String email;
  // ignore: non_constant_identifier_names
  final String UserType;
  final String messageStatus;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      // ignore: non_constant_identifier_names
      required this.UserType,
      required this.messageStatus});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      UserType: json['UserType'],
      messageStatus: json['messageStatus'],
    );
  }
}
