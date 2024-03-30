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


class CreateDrawMode2 extends StatefulWidget {
  const CreateDrawMode2({Key? key}) : super(key: key);

  @override
  State<CreateDrawMode2> createState() => _CreateDrawMode2State();
}
class _CreateDrawMode2State extends State<CreateDrawMode2> {
  final formK = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
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
        title: Text("Cuenta regresive",style: FlutterFlowTheme.of(context).titleMedium,),
      ),
      body: Form(
        key: formK,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  controller: priceC,
                  decoration: InputDecoration(
                    labelText: 'Valor del Sorteo',
                    labelStyle: FlutterFlowTheme.of(context)
                        .headlineSmall,
                    hintText: 'Valor del Sorteo',
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
              selectedDateTime == null?SizedBox():Text("$selectedDateTime",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 16,),
              _buildDefaultSingleDatePickerWithValue(),
              SizedBox(height: 16,),
              InkWell(
                onTap: ()async{
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      value: Time(hour: 0, minute: 0),
                      sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                      sunset: TimeOfDay(hour: 18, minute: 0), // optional
                      duskSpanInMinutes: 120, // optional
                      onChange: (v){
                        print(v.hour);
                        print(v.minute);
                        print(v.second);

                        drawTime = v.toString();
                        DateTime drawDate = _singleDatePickerValueWithDefaultValue[0]!;
                        setState(() {
                          selectedDateTime = DateTime(drawDate.year, drawDate.month,drawDate.day,v.hour,v.minute,v.second);
                          // selectedDateTime = DateTime(drawDate.month,drawDate.day,v.hour,v.minute,v.second);
                        });
                      },
                    ),
                  );
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
                  child: Column(
                    children: [
                      Text("Select Time",style: TextStyle(
                          color: FlutterFlowTheme.of(context).accent3,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                      SizedBox(height: 10,),
                      if(drawTime !=  null)
                        Text(
                          drawTime??'',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              InkWell(
                onTap: ()async{
                  if(selectedDateTime ==null){
                    Fluttertoast.showToast(msg: "Ingrese la fecha y hora de finalización del sorteo.");
                    return;
                  }
                  if(url == null){
                    Fluttertoast.showToast(msg: "La imagen no se puede vaciar.");
                    return;
                  }
                  if(formK.currentState!.validate()){
                    if(selectedDateTime!.compareTo(DateTime.now().add(Duration(minutes: 1)))>=1){
                      createDraw2(nameC.text, int.parse(priceC.text), selectedDateTime!,url!);
                    }
                    else{
                      Fluttertoast.showToast(msg: "Su tiempo seleccionado ya pasó o es menos de 3 minutos.");
                    }
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
                  child: Text("Submit",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                ),
              ),
              SizedBox(height: 46,),

              // TextButton(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       showPicker(
              //         context: context,
              //         value: Time(hour: 0, minute: 0),
              //         sunrise: TimeOfDay(hour: 6, minute: 0), // optional
              //         sunset: TimeOfDay(hour: 18, minute: 0), // optional
              //         duskSpanInMinutes: 120, // optional
              //         onChange: (v){
              //           print(v);
              //         },
              //       ),
              //     );
              //   },
              //   child: Text(
              //     "Open time picker",
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }


  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];


  DateTime? selectedDateTime;
  String? drawTime;
  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: FlutterFlowTheme.of(context).primaryBackground,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
      firstDate: DateTime.now(),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text('Pick Draw End Date',style: TextStyle(
            color: FlutterFlowTheme.of(context).primaryBackground,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),),
          CalendarDatePicker2(
            config: config,
            value: _singleDatePickerValueWithDefaultValue,
            onValueChanged: (dates){
              setState((){
                _singleDatePickerValueWithDefaultValue = dates;
                // selectedDateTime = dates[0];
              });
            }
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Selected Date:  ',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),),
              const SizedBox(width: 10),
              Text(
                _getValueText(
                  config.calendarType,
                  _singleDatePickerValueWithDefaultValue,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }


  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
      ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }



  Future createDraw2(String name,int value, DateTime dateTime,String img)async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection("Sorteo2").doc();
    documentReference.set({
      'name': name,
      'value': value,
      'image': img,
      'endTime': dateTime,
      'timer': false,
      'status': true,
      'soldTickets': [],
      'participants': [],
      'seeWinner': [],
      'uid': documentReference.id,
      'ref': documentReference,
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
