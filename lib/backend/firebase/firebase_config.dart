import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDeGJe_enml_LBOalDcUGLL_MIGB0Y_QEc",
            authDomain: "fitness-7dc1d.firebaseapp.com",
            projectId: "fitness-7dc1d",
            storageBucket: "fitness-7dc1d.appspot.com",
            messagingSenderId: "465590966916",
            appId: "1:465590966916:web:2cfa3e21223688fe7f00d1",
            measurementId: "G-FECKFJNJN4"));
  } else {
    await Firebase.initializeApp();
  }
}
