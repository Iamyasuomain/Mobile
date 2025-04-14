class Users {
  final String? username;
  final String? email;
  final String? password;
  Users({this.username, this.email, this.password});
  static Map<String, dynamic> toJson(Users x) =>
      {'username': x.username, 'email': x.email, 'password': x.password};
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        username: json['username'],
        email: json['email'],
        password: json['password']);
  }
}
