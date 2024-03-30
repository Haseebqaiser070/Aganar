import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_alert/custom_alert_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectTicketsModel extends FlutterFlowModel {
  ///  Local state fields for this component.

  String? selectedImage;

  int? imageNumber;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in ButtonTest widget.
  SorteosRecord? verifyEmojiStripe;
  // Stores action output result for [Firestore Query - Query a collection] action in ButtonTest widget.
  SorteosRecord? ticketFilterCard;
  // Stores action output result for [Backend Call - Create Document] action in ButtonTest widget.
  SelectedTicketsRecord? createUserTicket;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
