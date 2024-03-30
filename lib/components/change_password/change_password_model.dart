import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/login_signin/login_signin_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangePasswordModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for contrasenaActual widget.
  TextEditingController? contrasenaActualController;
  late bool contrasenaActualVisibility;
  String? Function(BuildContext, String?)? contrasenaActualControllerValidator;
  // State field(s) for nuevaContrasena widget.
  TextEditingController? nuevaContrasenaController;
  late bool nuevaContrasenaVisibility;
  String? Function(BuildContext, String?)? nuevaContrasenaControllerValidator;
  // Stores action output result for [Custom Action - changePassword] action in Button widget.
  bool? isChange;
  // Stores action output result for [Custom Action - changePassword] action in Button widget.
  bool? passChange;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    contrasenaActualVisibility = false;
    nuevaContrasenaVisibility = false;
  }

  void dispose() {
    contrasenaActualController?.dispose();
    nuevaContrasenaController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
