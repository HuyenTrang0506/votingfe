// To parse this JSON data, do
//
//     final electionModel = electionModelFromJson(jsonString);

import 'dart:convert';

List<ElectionModel> electionModelFromJson(String str) =>
    List<ElectionModel>.from(
        json.decode(str).map((x) => ElectionModel.fromJson(x)));

String electionModelToJson(List<ElectionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ElectionModel {
  String? title;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  List<ListCandidate>? listCandidates;

  ElectionModel({
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.listCandidates,
  });

  factory ElectionModel.fromJson(Map<String, dynamic> json) => ElectionModel(
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
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "listCandidates": listCandidates == null
            ? []
            : List<dynamic>.from(listCandidates!.map((x) => x.toJson())),
      };
}

class ListCandidate {
  String? name;
  String? description;
  String? imageUrl;
  String? contactInformation;

  ListCandidate({
    this.name,
    this.description,
    this.imageUrl,
    this.contactInformation,
  });

  factory ListCandidate.fromJson(Map<String, dynamic> json) => ListCandidate(
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        contactInformation: json["contactInformation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "contactInformation": contactInformation,
      };
}
