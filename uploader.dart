import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'fashion_challenges.dart';
import 'submissiongallery.dart';
import 'authservice.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController challengeNumberController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadData() async {
    if (_image == null || descriptionController.text.isEmpty || challengeNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields and upload an image.')),
      );
      return;
    }

    String description = descriptionController.text;
    String challengeNumber = challengeNumberController.text;
    String userId = AuthService.getCurrentUserId(); // Replace with the actual user ID

    // Reference to Firestore collection for challenges
    final challengeRef = FirebaseFirestore.instance.collection('challenge_room').doc('challenges').collection(challengeNumber);

    // Check if the challenge collection exists, create it if necessary
    if (!(await challengeRef.doc('placeholder').get()).exists) {
      await challengeRef.doc('placeholder').set({});
    }

    // Check if user has already uploaded for this challenge
    var existingSubmission = await challengeRef.where('userId', isEqualTo: userId).get();

    if (existingSubmission.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have already submitted for this challenge.')),
      );
      return;
    }

    // Upload image to Firebase Storage
    Reference storageRef = FirebaseStorage.instance.ref().child('challenges/$challengeNumber/${_image!.path.split('/').last}');
    UploadTask uploadTask = storageRef.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Upload data to Firestore
    await challengeRef.add({
      'userId': userId,
      'description': description,
      'imageUrl': downloadUrl,
      'likes': 0,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Submission successful!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Challenge'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: _image == null
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 300,
                          color: Colors.grey[200],
                          child: Center(
                            child: Text('Tap to select image'),
                          ),
                        )
                      : kIsWeb
                          ? Image.network(
                              _image!.path,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: challengeNumberController,
                  decoration: InputDecoration(
                    hintText: 'Enter challenge number',
                    labelText: 'Challenge Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'Upload',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubmissionGallery(challengeId: challengeNumberController.text)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'View Submissions',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
