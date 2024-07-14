import 'package:cloud_firestore/cloud_firestore.dart';

class LikeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateLikes(String challengeId, String submissionId) async {
    DocumentReference submissionRef = _firestore
        .collection('challenges')
        .doc(challengeId)
        .collection('submissions')
        .doc(submissionId);

    _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(submissionRef);
      if (!snapshot.exists) {
        throw Exception("Submission does not exist!");
      }

      int newLikes = snapshot['likes'] + 1;
      transaction.update(submissionRef, {'likes': newLikes});
    });
  }
}
