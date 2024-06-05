class Candidate {
  final String id;
  final String name;
  final String bio;

  Candidate({required this.id, required this.name, required this.bio});

  // Factory constructor to create Candidate from JSON
  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'],
      name: json['name'],
      bio: json['bio'],
    );
  }

  // Method to convert Candidate to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
    };
  }
}
