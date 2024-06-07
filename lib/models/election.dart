// To parse this JSON data, do
//
//     final electionModel = electionModelFromJson(jsonString);

import 'dart:convert';

List<ElectionModel> electionListModelFromJson(String str) =>
    List<ElectionModel>.from(
        json.decode(str).map((x) => ElectionModel.fromJson(x)));

String electionListModelToJson(List<ElectionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ElectionModel {
  int? id;
  String? title;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  List<ListCandidate>? listCandidates;
  List<int>? userIds;

  ElectionModel({
    this.id,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.listCandidates,
    this.userIds,
  });

  factory ElectionModel.fromJson(Map<String, dynamic> json) => ElectionModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        listCandidates: json["listCandidates"] == null
            ? []
            : List<ListCandidate>.from(
                json["listCandidates"]!.map((x) => ListCandidate.fromJson(x))),
        userIds: json["userIds"] == null
            ? []
            : List<int>.from(json["userIds"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "listCandidates": listCandidates == null
            ? []
            : List<dynamic>.from(listCandidates!.map((x) => x.toJson())),
        "userIds":
            userIds == null ? [] : List<dynamic>.from(userIds!.map((x) => x)),
      };
}

class ListCandidate {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  String? contactInformation;

  ListCandidate({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.contactInformation,
  });

  factory ListCandidate.fromJson(Map<String, dynamic> json) => ListCandidate(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        contactInformation: json["contactInformation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "contactInformation": contactInformation,
      };
}
