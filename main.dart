import 'package:device_preview/device_preview.dart';
import 'package:fashion_challenger_system/fashion_challenges.dart';
import 'package:fashion_challenger_system/leaderboard.dart';
import 'package:fashion_challenger_system/loginpage.dart';
import 'package:fashion_challenger_system/models/challenges.dart';
import 'package:fashion_challenger_system/models/rewards.dart';
import 'package:fashion_challenger_system/signuppage.dart';
import 'package:fashion_challenger_system/uploader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fashion_challenger_system/landingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyDCEwR3MBbVDiYKyzCt-YM_ee_PGq3TpLU',
          appId: "1:146222671512:web:4da8e7db088b2b070cd2ed",
          messagingSenderId: "146222671512",
          projectId: "fashion-challenger-system",
          storageBucket: "gs://fashion-challenger-system.appspot.com"
        ),
      );
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    print("Error initializing Firebase or uploading data: $e");
  }

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      getPages: [
         GetPage(name: '/login', page: () => LoginSignup()),
        GetPage(name: '/challenges', page: () => FashionChallengesPage()),
        GetPage(name: '/signup', page: () => SignUp()),
        GetPage(name: '/rewards', page: () => Rewards()),
        GetPage(name: '/upload', page: () => UploadPage()),
        GetPage(
          name: '/leaderboard',
          page: () {
            return Leaderboard();
          },
        ),
      ],
      builder: DevicePreview.appBuilder,
    );
  }
}
