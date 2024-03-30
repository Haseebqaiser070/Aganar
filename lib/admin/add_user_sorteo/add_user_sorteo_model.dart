import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/custom_alert/custom_alert_widget.dart';
import '/components/custom_alert_general/custom_alert_general_widget.dart';
import '/components/no_users/no_users_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class AddUserSorteoModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for searchBar widget.
  TextEditingController? searchBarController;
  String? Function(BuildContext, String?)? searchBarControllerValidator;
  List<UsersRecord> simpleSearchResults = [];
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? selectedTicketsCount;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  SelectedTicketsRecord? cashPaymentUser;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificacionesRecord? emojiNotify;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? selectedTicketsCountSeek;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  SelectedTicketsRecord? cashPaymentUserSeek;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificacionesRecord? emojiNotifySeek;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    searchBarController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
