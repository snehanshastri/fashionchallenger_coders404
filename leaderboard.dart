import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion_challenger_system/firebase_implementations/challenge_service.dart';

class Leaderboard extends StatelessWidget {
  final ChallengeService _challengeService = ChallengeService();

  @override
  Widget build(BuildContext context) {
    final String challengeId = Get.parameters['challengeId'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _challengeService.fetchLeaderboard(challengeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No submissions yet'));
          } else {
            final submissions = snapshot.data!;
            print('Rendering ${submissions.length} submissions');
            return ListView.builder(
              itemCount: submissions.length,
              itemBuilder: (context, index) {
                final submission = submissions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(submission['imageUrl']),
                  ),
                  title: Text('User: ${submission['uid']}'),
                  subtitle: Text('Likes: ${submission['likes']}'),
                  trailing: Text('#${index + 1}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
