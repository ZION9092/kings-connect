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
    apiKey: 'AIzaSyBsuSPvVgC-alQ15rVonX8KGjEkvEnegg8',
    appId: '1:1035737767250:web:76bb73ccbc0b4fd8d6ee8b',
    messagingSenderId: '1035737767250',
    projectId: 'catalog-app-b65db',
    authDomain: 'catalog-app-b65db.firebaseapp.com',
    storageBucket: 'catalog-app-b65db.appspot.com',
    measurementId: 'G-0PR2MYYB6N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGB2T-95mbmuT59V2z-QJs3z5TCRokl7M',
    appId: '1:1035737767250:android:03029b7b03fb7af6d6ee8b',
    messagingSenderId: '1035737767250',
    projectId: 'catalog-app-b65db',
    storageBucket: 'catalog-app-b65db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpkfdP9KEr0wUDHdb-Tj1t0R78DlMQcmc',
    appId: '1:1035737767250:ios:3ed2284f0a708bcdd6ee8b',
    messagingSenderId: '1035737767250',
    projectId: 'catalog-app-b65db',
    storageBucket: 'catalog-app-b65db.appspot.com',
    iosBundleId: 'com.example.kingsConnect',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDpkfdP9KEr0wUDHdb-Tj1t0R78DlMQcmc',
    appId: '1:1035737767250:ios:3ed2284f0a708bcdd6ee8b',
    messagingSenderId: '1035737767250',
    projectId: 'catalog-app-b65db',
    storageBucket: 'catalog-app-b65db.appspot.com',
    iosBundleId: 'com.example.kingsConnect',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBsuSPvVgC-alQ15rVonX8KGjEkvEnegg8',
    appId: '1:1035737767250:web:7fa7f36cc159a4c9d6ee8b',
    messagingSenderId: '1035737767250',
    projectId: 'catalog-app-b65db',
    authDomain: 'catalog-app-b65db.firebaseapp.com',
    storageBucket: 'catalog-app-b65db.appspot.com',
    measurementId: 'G-8HYK14512X',
  );
}
