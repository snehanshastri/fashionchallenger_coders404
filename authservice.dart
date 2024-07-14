import 'package:fashion_challenger_system/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;


class AuthService {
  static final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  static firebase_auth.User? get currentUser => _auth.currentUser;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  static String getCurrentUserId() {
    return _auth.currentUser?.uid ?? '';
  }

Future<User?> fetchUserData(firebase_auth.User firebaseUser) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (doc.exists) {
        return User.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }
  // Add more authentication methods if needed
}
