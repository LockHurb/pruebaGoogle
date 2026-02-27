import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Opciones de configuración de Firebase por plataforma.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions no está configurado para ${defaultTargetPlatform.name}',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDyCHOLq23iezJyMdopKqVZdOfB6semEnU',
    appId: '1:425438544932:web:92f11bbe64c4a7425644b1',
    messagingSenderId: '425438544932',
    projectId: 'prueba-flutter-98316',
    storageBucket: 'prueba-flutter-98316.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmqBxSBT_33l66cp4mHelrDwuAJoiTbhI',
    appId: '1:425438544932:android:37f5cf9799b18d585644b1',
    messagingSenderId: '425438544932',
    projectId: 'prueba-flutter-98316',
    storageBucket: 'prueba-flutter-98316.firebasestorage.app',
  );
}
