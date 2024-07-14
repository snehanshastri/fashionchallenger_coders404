import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion_challenger_system/firebase_implementations/challenge_service.dart';
import 'package:fashion_challenger_system/firebase_implementations/like_service.dart';

class Leaderboard extends StatelessWidget {
  final ChallengeService _challengeService = ChallengeService();
  final LikeService _likeService = LikeService();

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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('#${index + 1}'),
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () async {
                          await _likeService.updateLikes(
                            challengeId,
                            submission['submissionId'],
                          );
                          Get.snackbar(
                            'Liked!',
                            'You liked the submission.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
