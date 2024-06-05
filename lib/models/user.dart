// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  final int? id;
  final String? fullname;
  final String? email;
  final String? avatarUrl;
  final List<String>? roles;

  UserModel({
    this.id,
    this.fullname,
    this.email,
    this.avatarUrl,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] == null ? null : json["id"],
      fullname: json["fullname"] == null ? "Empty" : json["fullname"],
      email: json["email"] == null ? null : json["email"],
      avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
      roles: json["roles"] == null
          ? []
          : List<String>.from(json["roles"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname == null ? null : fullname,
        "email": email == null ? null : email,
        "avatarUrl": avatarUrl == null ? null : avatarUrl,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
      };
}
