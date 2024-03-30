import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sorteoaganar/flutter_flow/flutter_flow_theme.dart';

import '../../backend/firebase_storage/storage.dart';
import '../../flutter_flow/upload_data.dart';
import '../../flutter_flow/uploaded_file.dart';
import '../../user/inicio/inicio_widget.dart';


class createPrivateDraw extends StatefulWidget {
  const createPrivateDraw({Key? key}) : super(key: key);

  @override
  State<createPrivateDraw> createState() => _createPrivateDrawState();
}
class _createPrivateDrawState extends State<createPrivateDraw> {
  final formK = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController limiteC = TextEditingController();
  TextEditingController ticketLimteC = TextEditingController();
  TextEditingController codeC = TextEditingController();
  File? imageFile;
  String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: FlutterFlowTheme.of(context).accent3,)),
        title: Text("Private Draw",style: FlutterFlowTheme.of(context).titleMedium,),
      ),
      body: Form(
        key: formK,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  final selectedMedia =
                  await selectMediaWithSourceBottomSheet(
                    context: context,
                    imageQuality: 75,
                    allowPhoto: true,
                    textColor:
                    FlutterFlowTheme.of(context).primaryBackground,
                    pickerFontFamily: 'Montserrat',
                  );
                  if (selectedMedia != null &&
                      selectedMedia.every((m) =>
                          validateFileFormat(
                              m.storagePath, context))) {
                    // setState(() => _model.isDataUploading = true);
                    var selectedUploadedFiles =
                    <FFUploadedFile>[];

                    var downloadUrls = <String>[];

                    try {
                      selectedUploadedFiles = selectedMedia
                          .map((m) => FFUploadedFile(
                        name:
                        m.storagePath.split('/').last,
                        bytes: m.bytes,
                        height: m.dimensions?.height,
                        width: m.dimensions?.width,
                        blurHash: m.blurHash,
                      ))
                          .toList();

                      downloadUrls = (await Future.wait(
                        selectedMedia.map(
                              (m) async => await uploadData(
                              m.storagePath, m.bytes),
                        ),
                      ))
                          .where((u) => u != null)
                          .map((u) => u!)
                          .toList();
                    }
                    catch(e){
                      print("errorn");
                      print(e);
                    }
                    // finally {
                    //   _model.isDataUploading = false;
                    // }
                    if (selectedUploadedFiles.length ==
                        selectedMedia.length &&
                        downloadUrls.length ==
                            selectedMedia.length) {
                      setState(() {
                        url =
                            downloadUrls.first;
                      });
                    } else {
                      setState(() {});
                      return;
                    }
                  }
                },
                // onTap: ()async{
                //   XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                //   if(xfile != null){
                //     imageFile = File(xfile.path);
                //     uploadImage(imageFile!);
                //
                //   }
                // },
                child: Container(
                  margin: EdgeInsetsDirectional.fromSTEB(
                      16.0, 16.0, 16.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  alignment: Alignment.center,
                  child: url != null?
                  Image.network(url!,fit: BoxFit.contain,)
                      :Icon(
                    Icons.image_search_outlined,
                    color:
                    FlutterFlowTheme.of(context).plumpPurple,
                    size: 99.0,
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    16.0, 16.0, 16.0, 0.0),
                child: TextFormField(
                  controller: nameC,
                  decoration: InputDecoration(
                    labelText: 'Nombre de Sorteo',
                    labelStyle: FlutterFlowTheme.of(context)
                        .headlineSmall,
                    hintText: 'Nombre del Sorteo',
                    hintStyle: FlutterFlowTheme.of(context).titleSmall,

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).info,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsetsDirectional.fromSTEB(
                        20.0, 32.0, 20.0, 12.0),
                  ),
                  style: FlutterFlowTheme.of(context)
                      .headlineSmall
                      .override(
                    fontFamily: 'Montserrat',
                    useGoogleFonts: GoogleFonts.asMap()
                        .containsKey(FlutterFlowTheme.of(context)
                        .headlineSmallFamily),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    16.0, 16.0, 16.0, 0.0),
                child: TextFormField(
                  controller: limiteC,
                  decoration: InputDecoration(
                    labelText: 'límite de participantes',
                    labelStyle: FlutterFlowTheme.of(context)
                        .headlineSmall,
                    hintText: 'límite de participantes',
                    hintStyle: FlutterFlowTheme.of(context).titleSmall,

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).info,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsetsDirectional.fromSTEB(
                        20.0, 32.0, 20.0, 12.0),
                  ),
                  style: FlutterFlowTheme.of(context)
                      .headlineSmall
                      .override(
                    fontFamily: 'Montserrat',
                    useGoogleFonts: GoogleFonts.asMap()
                        .containsKey(FlutterFlowTheme.of(context)
                        .headlineSmallFamily),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    16.0, 16.0, 16.0, 0.0),
                child: TextFormField(
                  controller: ticketLimteC,
                  decoration: InputDecoration(
                    labelText: 'Boleto límite',
                    labelStyle: FlutterFlowTheme.of(context)
                        .headlineSmall,
                    hintText: 'Boleto límite',
                    hintStyle: FlutterFlowTheme.of(context).titleSmall,

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).info,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsetsDirectional.fromSTEB(
                        20.0, 32.0, 20.0, 12.0),
                  ),
                  style: FlutterFlowTheme.of(context)
                      .headlineSmall
                      .override(
                    fontFamily: 'Montserrat',
                    useGoogleFonts: GoogleFonts.asMap()
                        .containsKey(FlutterFlowTheme.of(context)
                        .headlineSmallFamily),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    16.0, 16.0, 16.0, 0.0),
                child: TextFormField(
                  controller: codeC,
                  decoration: InputDecoration(
                    labelText: 'código de participación',
                    labelStyle: FlutterFlowTheme.of(context)
                        .headlineSmall,
                    hintText: 'código de participación',
                    hintStyle: FlutterFlowTheme.of(context).titleSmall,

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).info,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsetsDirectional.fromSTEB(
                        20.0, 32.0, 20.0, 12.0),
                  ),
                  style: FlutterFlowTheme.of(context)
                      .headlineSmall
                      .override(
                    fontFamily: 'Montserrat',
                    useGoogleFonts: GoogleFonts.asMap()
                        .containsKey(FlutterFlowTheme.of(context)
                        .headlineSmallFamily),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              SizedBox(height: 16,),
              InkWell(
                onTap: ()async{

                  if(url == null){
                    Fluttertoast.showToast(msg: "La imagen no se puede vaciar.");
                    return;
                  }
                  if(formK.currentState!.validate()){
                    createPrivateDraw(nameC.text,int.parse(limiteC.text),int.parse(ticketLimteC.text),codeC.text,url!);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  alignment: Alignment.center,
                  child: Text("Entregar",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                ),
              ),
              SizedBox(height: 46,),
            ],
          ),
        ),
      ),
    );
  }


  Future createPrivateDraw(String name,int limite,int ticketlimite,String code,String img)async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection("Sorteo4").doc();
    documentReference.set({
      'name': name,
      'limite': limite,
      'ticketLimite': ticketlimite,
      'image': img,
      'code': code,
      'timer': false,
      'status': true,
      'seeWinner': [],
      'participants': [],
      'soldTickets': [],
      'ref': documentReference,
      'uid': documentReference.id,
      'endTime': FieldValue.serverTimestamp(),
      'createAt': DateTime.now()
    }).then((value){
      Fluttertoast.showToast(msg: "Se ha creado el sorteo.");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> InicioWidget()), (route) => false);
    });
  }



  Future uploadImage(File imgFile)async{
    String fileName = path.basename(imgFile.path);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final ref = firebaseStorage.ref().child('StudentsProfileImages/$fileName');
    await ref.putFile(imgFile);
    url = await ref.getDownloadURL();
    setState(() {
    });
  }
}

