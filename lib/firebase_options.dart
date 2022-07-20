// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDn0nwgw4q7jn4a-aoo9JMxB1kDjamuMZQ',
    appId: '1:878210617141:web:84aa10d1fd5e4ea0c4067c',
    messagingSenderId: '878210617141',
    projectId: 'planner-app-8029a',
    authDomain: 'planner-app-8029a.firebaseapp.com',
    storageBucket: 'planner-app-8029a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAn8N1d4qaU4Y_GtBQavuhTZEBagtZRBgc',
    appId: '1:878210617141:android:3671ba39c2153a8cc4067c',
    messagingSenderId: '878210617141',
    projectId: 'planner-app-8029a',
    storageBucket: 'planner-app-8029a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBH8KNP4a-dzwXYo8hERRa3NTu-ljg-jZM',
    appId: '1:878210617141:ios:5d33aedb92c9fd92c4067c',
    messagingSenderId: '878210617141',
    projectId: 'planner-app-8029a',
    storageBucket: 'planner-app-8029a.appspot.com',
    iosClientId: '878210617141-l29edo37s7svkutmnsbn3re7hos8tir6.apps.googleusercontent.com',
    iosBundleId: 'com.example.calendarApp',
  );
}