import 'dart:convert';

EntityError userErrorFromJson(String str) =>
    EntityError.fromJson(json.decode(str));

String userErrorToJson(EntityError data) => json.encode(data.toJson());

class EntityError {
  EntityError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory EntityError.fromJson(Map<String, dynamic> json) => EntityError(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };
}
