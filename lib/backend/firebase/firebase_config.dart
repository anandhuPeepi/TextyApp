import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBBfGTE3c-VE2oSkXj7m0Pe9cYd-5RAKYA",
            authDomain: "texy-app-9vjfub.firebaseapp.com",
            projectId: "texy-app-9vjfub",
            storageBucket: "texy-app-9vjfub.appspot.com",
            messagingSenderId: "385276065417",
            appId: "1:385276065417:web:781e6e4e08fc69af027858"));
  } else {
    await Firebase.initializeApp();
  }
}
