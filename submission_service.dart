import 'package:cloud_firestore/cloud_firestore.dart';

class SubmissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchSubmissions(String challengeId) async {
    final querySnapshot = await _firestore.collection('challenges')
        .doc(challengeId)
        .collection('submissions')
        .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> updateLikes(String challengeId, String submissionId) async {
    final submissionRef = _firestore.collection('challenges')
        .doc(challengeId)
        .collection('submissions')
        .doc(submissionId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(submissionRef);
      if (snapshot.exists) {
        final currentLikes = snapshot.data()?['likes'] ?? 0;
        transaction.update(submissionRef, {'likes': currentLikes + 1});
      }
    });
  }
}
