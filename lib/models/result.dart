class ElectionResult {
  final String electionId;
  final Map<String, int>
      candidateVotes; // key: candidateId, value: number of votes

  ElectionResult({required this.electionId, required this.candidateVotes});

  // Factory constructor to create ElectionResult from JSON
  factory ElectionResult.fromJson(Map<String, dynamic> json) {
    return ElectionResult(
      electionId: json['electionId'],
      candidateVotes: Map<String, int>.from(json['candidateVotes']),
    );
  }

  // Method to convert ElectionResult to JSON
  Map<String, dynamic> toJson() {
    return {
      'electionId': electionId,
      'candidateVotes': candidateVotes,
    };
  }
}
