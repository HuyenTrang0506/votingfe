import 'dart:convert';

List<UserModel> userListModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  final int? id;
  String? fullname;
  String? email;
  String? accessToken;
  String? avatarUrl;
  List<String>? roles;
  String? password;
  bool? pro;

  UserModel({
    this.id,
    this.fullname,
    this.email,
    this.accessToken,
    this.avatarUrl,
    this.roles,
    this.password,
    this.pro,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      fullname: json["fullname"],
      email: json["email"],
      accessToken: json["accessToken"],
      avatarUrl: json["avatarUrl"],
      roles: json["roles"] == null
          ? []
          : List<String>.from(json["roles"].map((x) => x)),
      password: json["password"],
      pro: json[
          "pro"], // Bạn có thể không lưu password trong JSON tùy theo yêu cầu bảo mật
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "accessToken": accessToken,
        "avatarUrl": avatarUrl,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "password": password,
        "pro":
            pro, // Bạn có thể không xuất password ra JSON tùy theo yêu cầu bảo mật
      };

  // Phương thức từ JSON cho đăng ký
  factory UserModel.signUpFromJson(Map<String, dynamic> json) {
    return UserModel(
      fullname: json["fullname"],
      email: json["email"],
      password: json["password"],
    );
  }

  // Phương thức từ JSON cho đăng nhập
  factory UserModel.signInFromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
    );
  }
}
