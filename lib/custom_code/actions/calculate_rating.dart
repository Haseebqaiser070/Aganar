// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!

import 'dart:math' as math;

Future<double> calculateRating(
  double calificacionActual,
  int numeroDeCalificaciones,
  double nuevaCalificacion,
) async {
  // Add your function code here!

  double ratingCal =
      ((calificacionActual * numeroDeCalificaciones) + nuevaCalificacion) /
          (numeroDeCalificaciones + 1);
  return ratingCal;
}
