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
        return macos;
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
    apiKey: 'AIzaSyDIj3vUfBAkWhpyS-Eq78vvj3ZkVUCheHo',
    appId: '1:512818988801:web:dfe4602d48ac012571fd00',
    messagingSenderId: '512818988801',
    projectId: 'auth-tutorial-f7d29',
    authDomain: 'auth-tutorial-f7d29.firebaseapp.com',
    storageBucket: 'auth-tutorial-f7d29.appspot.com',
    measurementId: 'G-XL4L0DXPGC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5WTGTmP6ZptuOxFXs6rtshkakkHZos_M',
    appId: '1:512818988801:android:ba9ea9704f24fc6671fd00',
    messagingSenderId: '512818988801',
    projectId: 'auth-tutorial-f7d29',
    storageBucket: 'auth-tutorial-f7d29.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYUkzA7YCb5W_LK3aFsqGcOsMRZ4S-fNg',
    appId: '1:512818988801:ios:2fd0c9f62fcf52ea71fd00',
    messagingSenderId: '512818988801',
    projectId: 'auth-tutorial-f7d29',
    storageBucket: 'auth-tutorial-f7d29.appspot.com',
    iosBundleId: 'com.example.flutterBloc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYUkzA7YCb5W_LK3aFsqGcOsMRZ4S-fNg',
    appId: '1:512818988801:ios:24a0e0f65b08f96c71fd00',
    messagingSenderId: '512818988801',
    projectId: 'auth-tutorial-f7d29',
    storageBucket: 'auth-tutorial-f7d29.appspot.com',
    iosBundleId: 'com.example.flutterBloc.RunnerTests',
  );
}
