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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBlcIVmqWyDxaJt1nKZ0tejhCIxCIlSTVM',
    appId: '1:611878431720:web:260c497f2a73549ee9925d',
    messagingSenderId: '611878431720',
    projectId: 'insta-flutter-fire',
    authDomain: 'insta-flutter-fire.firebaseapp.com',
    storageBucket: 'insta-flutter-fire.appspot.com',
    measurementId: 'G-XL6XG8LJ9K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQNYWM306vhXd7-PeAH2zsfGCPNULaIlo',
    appId: '1:611878431720:android:42862c8a2ee67245e9925d',
    messagingSenderId: '611878431720',
    projectId: 'insta-flutter-fire',
    storageBucket: 'insta-flutter-fire.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgzYzZaMYlWzk_PyBZFbDKm08a4GGdMSA',
    appId: '1:611878431720:ios:ca4687e180d12422e9925d',
    messagingSenderId: '611878431720',
    projectId: 'insta-flutter-fire',
    storageBucket: 'insta-flutter-fire.appspot.com',
    iosClientId:
        '611878431720-4koh7fr4fist6nrlk0pkcas08c1n3qdl.apps.googleusercontent.com',
    iosBundleId: 'com.luckuveryx.instaFlutterFire',
  );
}
