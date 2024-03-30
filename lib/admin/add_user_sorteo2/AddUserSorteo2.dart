import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorteoaganar/admin/addSorteo2User/AddSorteo2User.dart';
import 'package:sorteoaganar/auth/firebase_auth/auth_util.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';


class AddUserSorteo2 extends StatefulWidget {
  AddUserSorteo2({Key? key,required this.Drawref}) : super(key: key);
  DocumentReference Drawref;

  @override
  State<AddUserSorteo2> createState() => _AddUserSorteo2State();
}

class _AddUserSorteo2State extends State<AddUserSorteo2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").where('activo', isEqualTo: true).snapshots(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryBackground,),);
          }
          if(snapshot.connectionState == ConnectionState.active){
            return ListView(
              children: snapshot.data!.docs.map((e){
                return Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(
                      16.0, 8.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                      FlutterFlowTheme.of(context)
                          .primaryBackground,
                      borderRadius:
                      BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional
                          .fromSTEB(8.0, 8.0, 8.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(
                                8.0),
                            child: Image.network(
                              valueOrDefault<String>(
                                e.data()['photo_url'],
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ruleta-izygr8/assets/gk8cg20c6m84/woman_avaatr.png',
                              ),
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional
                                  .fromSTEB(
                                  16.0,
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Column(
                                mainAxisSize:
                                MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    e.data()['display_name']??"",
                                    textAlign:
                                    TextAlign.start,
                                    maxLines: 2,
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .titleMedium
                                        .override(
                                      fontFamily:
                                      'Montserrat',
                                      fontSize:
                                      18.0,
                                      useGoogleFonts: GoogleFonts
                                          .asMap()
                                          .containsKey(
                                          FlutterFlowTheme.of(context)
                                              .titleMediumFamily),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(
                                        0.0,
                                        10.0,
                                        0.0,
                                        0.0),
                                    child: AutoSizeText(
                                        e.data()['email'],
                                      textAlign:
                                      TextAlign
                                          .start,
                                      maxLines: 2,
                                      style: FlutterFlowTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'Montserrat',
                                        fontSize:
                                        14.0,
                                        useGoogleFonts: GoogleFonts
                                            .asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(
                                        0.0,
                                        10.0,
                                        0.0,
                                        0.0),
                                    child: AutoSizeText(
                                        e.data()['phone_number']??"",
                                      textAlign:
                                      TextAlign
                                          .start,
                                      maxLines: 2,
                                      style: FlutterFlowTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'Montserrat',
                                        fontSize:
                                        16.0,
                                        useGoogleFonts: GoogleFonts
                                            .asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional
                                .fromSTEB(10.0, 0.0,
                                0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed:() async {
                                Map<String,dynamic> drawData = {};
                                await widget.Drawref.get().then((value){
                                  drawData = value.data() as Map<String,dynamic>;
                                });
                                if(!drawData['participants'].contains(e.reference)){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddSorteo2User(sorteo: drawData,userRef: e.reference,)));
                                }
                                else{
                                  Fluttertoast.showToast(msg: "Usuario ya agregado.");
                                }
                              },
                              text: 'Añadir',
                              options: FFButtonOptions(
                                padding:
                                EdgeInsetsDirectional
                                    .fromSTEB(
                                    10.0,
                                    20.0,
                                    10.0,
                                    20.0),
                                iconPadding:
                                EdgeInsetsDirectional
                                    .fromSTEB(
                                    0.0,
                                    0.0,
                                    0.0,
                                    0.0),
                                color:
                                FlutterFlowTheme.of(
                                    context)
                                    .primary,
                                textStyle:
                                FlutterFlowTheme.of(
                                    context)
                                    .titleSmall
                                    .override(
                                  fontFamily:
                                  'Noto Sans Hebrew',
                                  color: Colors
                                      .white,
                                  useGoogleFonts: GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      FlutterFlowTheme.of(context)
                                          .titleSmallFamily),
                                ),
                                elevation: 1.0,
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent,
                                  width: 1.0,
                                ),
                                borderRadius:
                                BorderRadius
                                    .circular(12.0),
                                disabledColor:
                                FlutterFlowTheme.of(
                                    context)
                                    .lineColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
          return SizedBox();
    },
      ),
    );
  }
}
