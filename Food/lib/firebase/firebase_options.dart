import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAjsEesHXPdlUPxhZr7jfTeDeIQS6of5V0',
    appId: '1:971068595174:web:b4f2e6648f8875ce1b9427',
    messagingSenderId: '971068595174',
    projectId: 'fir-flutter-c4ab4',
    authDomain: 'fir-flutter-c4ab4.firebaseapp.com',
    storageBucket: 'fir-flutter-c4ab4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPZ2ngQ4dsnPlhDiV2RVC_Ge3f3ot8j7k',
    appId: '1:971068595174:android:31c3e41db5e938fd1b9427',
    messagingSenderId: '971068595174',
    projectId: 'fir-flutter-c4ab4',
    storageBucket: 'fir-flutter-c4ab4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUguVqlyO5bHcyEj1QeGm2hjtZrbUdpwQ',
    appId: '1:971068595174:ios:3a99ff7c73f6fd1b1b9427',
    messagingSenderId: '971068595174',
    projectId: 'fir-flutter-c4ab4',
    storageBucket: 'fir-flutter-c4ab4.appspot.com',
    iosBundleId: 'com.example.shopApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUguVqlyO5bHcyEj1QeGm2hjtZrbUdpwQ',
    appId: '1:971068595174:ios:ef34a10a1564b7ec1b9427',
    messagingSenderId: '971068595174',
    projectId: 'fir-flutter-c4ab4',
    storageBucket: 'fir-flutter-c4ab4.appspot.com',
    iosBundleId: 'com.example.shopApp.RunnerTests',
  );
}
