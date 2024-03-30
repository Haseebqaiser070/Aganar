import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>> makeCloudCall(
  String callName,
  Map<String, dynamic> input,
) async {
  try {
    final response = await FirebaseFunctions.instance
        .httpsCallable(callName, options: HttpsCallableOptions())
        .call(input);
    return response.data is Map
        ? Map<String, dynamic>.from(response.data as Map)
        : {};
  } on FirebaseFunctionsException catch (e) {
    if (e is FirebaseFunctionsException) {
      print(
        'Cloud call error!\n'
        'Code: ${e.code}\n'
        'Details: ${e.details}\n'
        'Message: ${e.message}',
      );
    } else {
      print('Cloud call error: $e');
    }
    return {};
  }
}


Future<void> callCloudFunction() async {

  // Get the current user
  final User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    print("user not login.");
    throw Exception('User is not authenticated.');
  }

  final String token = await user.getIdToken();
  print("tooken $token");


  final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
    'checkAndUpdateTimer',
    options: HttpsCallableOptions(),
  );

  try {
    final result = await callable.call();
    print(result.data); // This will contain the result from your Cloud Function
  } catch (error) {
    print('Error calling Cloud Function: $error');
  }
}

