import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecuperarClaveModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextEmailReset widget.
  TextEditingController? textEmailResetController;
  String? Function(BuildContext, String?)? textEmailResetControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    textEmailResetController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
