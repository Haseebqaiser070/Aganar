import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorteoaganar/admin/sorteo_backend/sorteo_handler.dart';
import 'package:sorteoaganar/flutter_flow/flutter_flow_theme.dart';

import '../../backend/push_notifications/push_notifications_util.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';

class SendAdminNotification extends StatefulWidget {
  const SendAdminNotification({Key? key}) : super(key: key);

  @override
  State<SendAdminNotification> createState() => _SendAdminNotificationState();
}

class _SendAdminNotificationState extends State<SendAdminNotification> {
  TextEditingController titleC = TextEditingController();
  TextEditingController desC = TextEditingController();
  RxList<DocumentReference> selectedUser= <DocumentReference>[].obs;
  RxBool alluserCheckValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Color(0x007237ED),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).grayIcon,
            size: 30.0,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Enviar notificación',
          style: FlutterFlowTheme.of(context).titleLarge,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
            child: TextFormField(
              controller: titleC,
              decoration: InputDecoration(
                labelText: 'título',
                labelStyle: FlutterFlowTheme.of(context).headlineSmall,
                hintText: 'título',
                hintStyle: FlutterFlowTheme.of(context).titleSmall,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
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
                contentPadding:
                    EdgeInsetsDirectional.fromSTEB(20.0, 32.0, 20.0, 12.0),
              ),
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Montserrat',
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).headlineSmallFamily),
                  ),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
            child: TextFormField(
              controller: desC,
              decoration: InputDecoration(
                labelText: 'descripción',
                labelStyle: FlutterFlowTheme.of(context).headlineSmall,
                hintText: 'descripción',
                hintStyle: FlutterFlowTheme.of(context).titleSmall,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
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
                contentPadding:
                    EdgeInsetsDirectional.fromSTEB(20.0, 32.0, 20.0, 12.0),
              ),
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Montserrat',
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).headlineSmallFamily),
                  ),
              textAlign: TextAlign.start,
            ),
          ),
          InkWell(
            onTap: (){
              if(titleC.text == "" || desC.text == "" ){
                Fluttertoast.showToast(msg: "La notificación está vacía");
                return;
              }
              if(selectedUser.length == 0){
                Fluttertoast.showToast(msg: "No seleccionada por el usuario");
                return;
              }
              triggerPushNotification(
                notificationTitle:
                titleC.text,
                notificationText:
                desC.text,
                notificationSound:
                'default',
                userRefs: selectedUser,
                initialPageName:
                'notifications',
                parameterData: {},
              );
              sendToAllNotification(selectedUser,titleC.text,desC.text);
              Fluttertoast.showToast(msg: "Notificación enviada");
              Navigator.pop(context);
              print(selectedUser);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: FlutterFlowTheme.of(context).neon,
                        blurRadius: 10,
                        spreadRadius: 5
                    )
                  ],
                  border: Border.all(
                      color: Colors.white,
                      width: 2
                  )
              ),
              alignment: Alignment.center,
              child: Text("Enviar",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white
              ),),
            ),
          ),
          Divider(color: Colors.white,),
          Expanded(
              child: FutureBuilder(
            future: getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text(
                    "Loading.",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text(
                    "No Data!",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: FlutterFlowTheme.of(context).neon,
                                blurRadius: 10,
                                spreadRadius: 5
                            )
                          ],
                          border: Border.all(
                              color: Colors.white,
                              width: 2
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Select All",style: FlutterFlowTheme.of(context).labelLarge,),
                          SizedBox(width: 20,),
                          Obx(() =>Checkbox(value: alluserCheckValue.value, onChanged: (v){
                            alluserCheckValue.value = v!;
                            if(alluserCheckValue.value){
                              selectedUser.clear();
                              snapshot.data!.forEach((element) {
                                DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(element['uid']);
                                selectedUser.add(docRef);
                              });
                            }
                            else{
                              selectedUser.clear();
                            }
                          })),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: snapshot.data!.map((e){
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                      color: FlutterFlowTheme.of(context).neon,
                                      blurRadius: 10,
                                      spreadRadius: 5
                                  )
                                ],
                                border: Border.all(
                                    color: Colors.white,
                                    width: 2
                                )
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: e['photo_url'] == null?SizedBox():
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(e['photo_url'],fit: BoxFit.cover,),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(e['display_name']??"",style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        color: FlutterFlowTheme.of(context).accent3
                                      ),),
                                      SizedBox(height: 5,),
                                      Text(e['email']??"",style: TextStyle(
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                          color: FlutterFlowTheme.of(context).accent3
                                      ),),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Obx(() => Checkbox(
                                    value: selectedUser.contains(FirebaseFirestore.instance.collection("users").doc(e['uid']))?true:false,
                                    checkColor: FlutterFlowTheme.of(context).accent3,
                                    hoverColor: FlutterFlowTheme.of(context).accent3,
                                    onChanged: (v)async{
                                      DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(e['uid']);

                                      if(selectedUser.contains(docRef)){
                                        selectedUser.removeWhere((element) => element==docRef);
                                      }
                                      else{
                                        selectedUser.add(docRef);
                                      }

                                      print(selectedUser);
                                    }),),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                );
              }
              return Center(
                child: Text(
                  "No Data!",
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          )),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    List<Map<String, dynamic>> users = [];
    await FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        users.add(element.data());
      });
    });

    return users;
  }
}
