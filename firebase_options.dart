// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDCEwR3MBbVDiYKyzCt-YM_ee_PGq3TpLU',
    appId: '1:146222671512:web:4da8e7db088b2b070cd2ed',
    messagingSenderId: '146222671512',
    projectId: 'fashion-challenger-system',
    authDomain: 'fashion-challenger-system.firebaseapp.com',
    storageBucket: 'fashion-challenger-system.appspot.com',
    measurementId: 'G-X4GH4SXT7E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANA_ivp-dJ3qw-SviztFLrE72V03Xgl_4',
    appId: '1:146222671512:android:ec20ddbcbc03dc980cd2ed',
    messagingSenderId: '146222671512',
    projectId: 'fashion-challenger-system',
    storageBucket: 'fashion-challenger-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMYO7xRRQv10QvtEdSramn5DVrP_jTctk',
    appId: '1:146222671512:ios:f93fba042f4f7ac60cd2ed',
    messagingSenderId: '146222671512',
    projectId: 'fashion-challenger-system',
    storageBucket: 'fashion-challenger-system.appspot.com',
    iosBundleId: 'com.example.fashionChallengerSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMYO7xRRQv10QvtEdSramn5DVrP_jTctk',
    appId: '1:146222671512:ios:f93fba042f4f7ac60cd2ed',
    messagingSenderId: '146222671512',
    projectId: 'fashion-challenger-system',
    storageBucket: 'fashion-challenger-system.appspot.com',
    iosBundleId: 'com.example.fashionChallengerSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDCEwR3MBbVDiYKyzCt-YM_ee_PGq3TpLU',
    appId: '1:146222671512:web:479bb3ba17a894d20cd2ed',
    messagingSenderId: '146222671512',
    projectId: 'fashion-challenger-system',
    authDomain: 'fashion-challenger-system.firebaseapp.com',
    storageBucket: 'fashion-challenger-system.appspot.com',
    measurementId: 'G-03J4F6NBTW',
  );
}
