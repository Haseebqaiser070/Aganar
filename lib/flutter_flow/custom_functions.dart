import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

int indiceParticipant(
  List<DocumentReference> participantes,
  DocumentReference usuario,
) {
  // Get the Index of a Specific Element in a List
  int index = participantes.indexOf(usuario);
  return index;
}

double averageCalification(
  List<double> listCalificaciones,
  List<int> listNumCalifiaciones,
) {
  double sumCalificaciones = 0;
  int sumNumCalificaciones = 0;
  double calificacionPromedio = 0;

  for (double sumaCalifica in listCalificaciones) {
    sumCalificaciones += sumaCalifica;
  }

  for (int numCalificaciones in listNumCalifiaciones) {
    sumNumCalificaciones += numCalificaciones;
  }

  calificacionPromedio = sumCalificaciones / sumNumCalificaciones;

  if (calificacionPromedio.isNaN) {
    return 0;
  } else {
    return num.parse(calificacionPromedio.toStringAsFixed(1)).toDouble();
  }
}

int indiceTicket(
  List<String> listaTickets,
  String tickets,
) {
  // Get the Index of a Specific Element in a List
  int index = listaTickets.indexOf(tickets);
  return index;
}
