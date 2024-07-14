class Challenge {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final List<Submission> submissions;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.submissions,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      submissions: (json['submissions'] as List)
          .map((submissionJson) => Submission.fromJson(submissionJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'submissions': submissions.map((submission) => submission.toJson()).toList(),
    };
  }
}

class Submission {
  final String submissionId;
  final String uid;
  final String imageUrl;
  final String description;
  final int likes;

  Submission({
    required this.submissionId,
    required this.uid,
    required this.imageUrl,
    required this.description,
    required this.likes,
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      submissionId: json['submissionId'] as String,
      uid: json['uid'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      likes: json['likes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'submissionId': submissionId,
      'uid': uid,
      'imageUrl': imageUrl,
      'description': description,
      'likes': likes,
    };
  }
}
