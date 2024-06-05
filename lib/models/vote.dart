class Vote {
  final String id;
  final String electionId;
  final String voterId;
  final String candidateId;

  Vote(
      {required this.id,
      required this.electionId,
      required this.voterId,
      required this.candidateId});

  // Factory constructor to create Vote from JSON
  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      id: json['id'],
      electionId: json['electionId'],
      voterId: json['voterId'],
      candidateId: json['candidateId'],
    );
  }

  // Method to convert Vote to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'electionId': electionId,
      'voterId': voterId,
      'candidateId': candidateId,
    };
  }
}
