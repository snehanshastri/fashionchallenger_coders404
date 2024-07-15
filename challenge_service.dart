import 'package:cloud_firestore/cloud_firestore.dart';

class ChallengeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchLeaderboard(String challengeId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('challenge_room')
          .doc('challenges')
          .collection(challengeId)
          .orderBy('likes', descending: true)
          .get();

      print('Fetched ${snapshot.docs.length} submissions');

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['submissionId'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching leaderboard: $e');
      return [];
    }
  }
}
