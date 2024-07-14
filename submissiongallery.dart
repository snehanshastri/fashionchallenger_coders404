import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:fashion_challenger_system/firebase_implementations/submission_service.dart';

class SubmissionGallery extends StatefulWidget {
  final String challengeId;

  SubmissionGallery({required this.challengeId});

  @override
  _SubmissionGalleryState createState() => _SubmissionGalleryState();
}

class _SubmissionGalleryState extends State<SubmissionGallery> {
  final SubmissionService _submissionService = SubmissionService();
  late Future<List<Map<String, dynamic>>> _submissionsFuture;

  @override
  void initState() {
    super.initState();
    _submissionsFuture = _submissionService.fetchSubmissions(widget.challengeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submission Gallery'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _submissionsFuture,
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
                bool isLiked = submission['isLiked'] ?? false;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        submission['description'] ?? 'No description',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Image.network(
                        submission['imageUrl'],
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Likes: ${submission['likes']}'),
                          GestureDetector(
                            onTap: () async {
                              await _submissionService.updateLikes(
                                  widget.challengeId, submission['submissionId']);
                              setState(() {
                                submission['likes'] = (submission['likes'] ?? 0) + 1;
                                submission['isLiked'] = true;
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 24.0,
                            ),
                          ),
                        ],
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
