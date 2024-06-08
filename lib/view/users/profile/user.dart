class User {
  final int id;
  final String fullname;
  final String email;
  final String? accessToken;
  final String? avatarUrl;
  final List<String> roles;
  final bool pro;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    this.accessToken,
    this.avatarUrl,
    required this.roles,
    required this.pro,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      accessToken: json['accessToken'],
      avatarUrl: json['avatarUrl'],
      roles: List<String>.from(json['roles']),
      pro: json['pro'],
    );
  }
}
