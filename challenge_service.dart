import 'package:cloud_firestore/cloud_firestore.dart';

class ChallengeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchLeaderboard(String challengeId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('challenges')
        .doc(challengeId)
        .collection('submissions')
        .orderBy('likes', descending: true)
        .get();

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
