import 'package:cloud_firestore/cloud_firestore.dart';

class SubmissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchSubmissions(String challengeId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('challenge_room')
          .doc('challenges')
          .collection(challengeId)
          .get();

      List<Map<String, dynamic>> submissions = [];
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        data['submissionId'] = doc.id;  // Add the document ID to the data
        submissions.add(data);
      }
      return submissions;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateLikes(String challengeId, String submissionId) async {
    try {
      DocumentReference docRef = _firestore
          .collection('challenge_room')
          .doc('challenges')
          .collection(challengeId)
          .doc(submissionId);

      DocumentSnapshot doc = await docRef.get();
      int currentLikes = (doc.data() as Map<String, dynamic>)['likes'] ?? 0;
      await docRef.update({'likes': currentLikes + 1});
    } catch (e) {
      throw e;
    }
  }
}
