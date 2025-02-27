import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/custom_alert_general/custom_alert_general_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/user/inicio/inicio_widget.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CrearSorteoModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for nombreSorteo widget.
  TextEditingController? nombreSorteoController;
  String? Function(BuildContext, String?)? nombreSorteoControllerValidator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for shortBio widget.
  TextEditingController? shortBioController;
  String? Function(BuildContext, String?)? shortBioControllerValidator;
  // State field(s) for TextFieldLimite widget.
  TextEditingController? textFieldLimiteController;
  String? Function(BuildContext, String?)? textFieldLimiteControllerValidator;
  // State field(s) for TextFieldvalor widget.
  TextEditingController? textFieldvalorController;
  String? Function(BuildContext, String?)? textFieldvalorControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  SorteosRecord? crearSorteo;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    nombreSorteoController?.dispose();
    shortBioController?.dispose();
    textFieldLimiteController?.dispose();
    textFieldvalorController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
