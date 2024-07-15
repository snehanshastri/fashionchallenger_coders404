import 'package:cloud_firestore/cloud_firestore.dart';

class LikeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateLikes(String challengeId, String submissionId) async {
    try {
      DocumentReference submissionRef = _firestore
          .collection('challenges')
          .doc(challengeId)
          .collection('submissions')
          .doc(submissionId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(submissionRef);
        if (snapshot.exists) {
          int currentLikes = snapshot.get('likes') ?? 0;
          transaction.update(submissionRef, {'likes': currentLikes + 1});
        }
      });
    } catch (e) {
      print('Error updating likes: $e');
    }
  }
}
