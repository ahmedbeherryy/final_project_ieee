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
    apiKey: 'AIzaSyABMGJUX6MYgpHdOK-wJybkVKS4b12fR84',
    appId: '1:259601970146:web:ac2195308e2cdff23fbfbb',
    messagingSenderId: '259601970146',
    projectId: 'final-project-ieee',
    authDomain: 'final-project-ieee.firebaseapp.com',
    storageBucket: 'final-project-ieee.appspot.com',
    measurementId: 'G-VX1VLDYLRN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYFcIQW8p6an4jTFf8yrgVXW1lW5Lz57s',
    appId: '1:259601970146:android:dc02a84d772345d63fbfbb',
    messagingSenderId: '259601970146',
    projectId: 'final-project-ieee',
    storageBucket: 'final-project-ieee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKwxGGifOkUGXQ8OPdUd-GsGu14rDJebA',
    appId: '1:259601970146:ios:056efae343f193983fbfbb',
    messagingSenderId: '259601970146',
    projectId: 'final-project-ieee',
    storageBucket: 'final-project-ieee.appspot.com',
    iosBundleId: 'com.example.finalProjectIeee',
  );
}
