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
    apiKey: 'AIzaSyBrAZIm-2qrYJ4_ZG2g6h7gVblYTIOPgms',
    appId: '1:977802706651:web:9a811c669aa504e895d6fe',
    messagingSenderId: '977802706651',
    projectId: 'iremia-c228c',
    authDomain: 'iremia-c228c.firebaseapp.com',
    storageBucket: 'iremia-c228c.firebasestorage.app',
    measurementId: 'G-Z1PPE6G24H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5OUSxS32cvhmJfrG4pgDmgF7cdba0QEM',
    appId: '1:977802706651:android:de95b2e23004c1ff95d6fe',
    messagingSenderId: '977802706651',
    projectId: 'iremia-c228c',
    storageBucket: 'iremia-c228c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjbn3KAMVVbPdbKDcQSa1wXtmpE_ermqg',
    appId: '1:977802706651:ios:e92257c3dd9e4e8995d6fe',
    messagingSenderId: '977802706651',
    projectId: 'iremia-c228c',
    storageBucket: 'iremia-c228c.firebasestorage.app',
    iosBundleId: 'com.example.iremia',
  );
}
