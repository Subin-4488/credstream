class User {
  String? name;
  DateTime? dateofbirth;
  String email;
  String password;

  User(
      {this.name,
      this.dateofbirth,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> user) => User(
        name: user["name"],
        dateofbirth: user["dateofbirth"],
        email: user["email"],
        password: user["password"],
      );

  static Map<String, dynamic> toJson(User user) => {
        'name': user.name ?? '',
        'date_of_birth':
            user.dateofbirth != null ? user.dateofbirth!.toIso8601String() : '',
        'email': user.email,
        'password': user.password,
      };
}
