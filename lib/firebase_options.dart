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
    apiKey: 'AIzaSyAb4Q2sNEW-yDdOUWdPujzSPvjVUS8beXA',
    appId: '1:888263231558:web:f07cdeb8be7bffa507a247',
    messagingSenderId: '888263231558',
    projectId: 'bit-vehicle-management-system',
    authDomain: 'bit-vehicle-management-system.firebaseapp.com',
    storageBucket: 'bit-vehicle-management-system.appspot.com',
    measurementId: 'G-23HT6R8X04',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsFKNz4GakIkU-2GLySPdt7hgzn8T89ck',
    appId: '1:888263231558:android:5815a642ef67eda607a247',
    messagingSenderId: '888263231558',
    projectId: 'bit-vehicle-management-system',
    storageBucket: 'bit-vehicle-management-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACc4WfNvqDR6NDQJ8XJj29vFArJ6Sm7qc',
    appId: '1:888263231558:ios:5c30df28cb6be12e07a247',
    messagingSenderId: '888263231558',
    projectId: 'bit-vehicle-management-system',
    storageBucket: 'bit-vehicle-management-system.appspot.com',
    iosClientId: '888263231558-ga40vmm7bnssocurnrchttp3mv8uk7fc.apps.googleusercontent.com',
    iosBundleId: 'com.example.bitVehicleWeb',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACc4WfNvqDR6NDQJ8XJj29vFArJ6Sm7qc',
    appId: '1:888263231558:ios:47db0b055ffdfc0907a247',
    messagingSenderId: '888263231558',
    projectId: 'bit-vehicle-management-system',
    storageBucket: 'bit-vehicle-management-system.appspot.com',
    iosClientId: '888263231558-pvc1b5ri805stpb70edcjs3s1ct046ec.apps.googleusercontent.com',
    iosBundleId: 'com.example.bitVehicleWeb.RunnerTests',
  );
}
