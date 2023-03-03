class User {
  String name;
  DateTime dateofbirth;
  String email;
  String password;

  User(
      {required this.name,
      required this.dateofbirth,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> user) => User(
        name: user["name"],
        dateofbirth: user["dateofbirth"],
        email: user["email"],
        password: user["password"],
      );

  static Map<String, dynamic> toJson(User user) => {
        'name': user.name,
        'dateofbirth': user.dateofbirth.toIso8601String(),
        'email': user.email,
        'password': user.password
      };
}
