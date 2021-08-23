class User {
  final String id;
  final String fullName;
  final String email;
  final String password;

  User({this.id, this.fullName, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'].toString(),
        fullName: json['fullName'],
        email: json['email'],
        password: json['password']);
  }
}
