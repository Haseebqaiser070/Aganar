import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCJNPThkOUUwtiVotrnNTjysElTy2l4GY8",
            authDomain: "kgpromos-76d07.firebaseapp.com",
            projectId: "kgpromos-76d07",
            storageBucket: "kgpromos-76d07.appspot.com",
            messagingSenderId: "826429194830",
            appId: "1:826429194830:web:9309fb41bb26cba8ecb91f"));
  } else {
    await Firebase.initializeApp();
  }
}
