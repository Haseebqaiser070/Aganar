import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorteoaganar/auth/firebase_auth/auth_util.dart';
import 'package:sorteoaganar/flutter_flow/flutter_flow_theme.dart';
import 'package:sorteoaganar/user/ShowAllParticipant/ShowAllParticipant.dart';
import 'package:sorteoaganar/user/ShowTicketList/ShowTicketList.dart';
import 'package:sorteoaganar/user/ShowTicketList3/ShowTicketList3.dart';
import 'dart:math' as math;
import '../../flutter_flow/flutter_flow_util.dart';

class Draw3Detail extends StatefulWidget {
  Draw3Detail({Key? key,required this.drawid}) : super(key: key);
  String drawid;
  @override
  State<Draw3Detail> createState() => _Draw3DetailState();
}

class _Draw3DetailState extends State<Draw3Detail> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<Map<String,dynamic>> getDraw()async{
    Map<String,dynamic> drawData = {};
    await firestore.collection("Sorteo3").doc(widget.drawid).get().then((value){
      if(value.data()!= null){
        drawData = value.data()!;
      }
    });
    return drawData;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      body: FutureBuilder(
        future: getDraw(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryBackground,),);
          }
          if(snapshot.connectionState == ConnectionState.done){
            Map<String,dynamic> data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(data['image'],fit: BoxFit.cover,)),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        16.0, 16.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 0.0),
                            child: Text(
                              data['name'],
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                fontFamily:
                                FlutterFlowTheme.of(context)
                                    .displaySmallFamily,
                                fontSize: 35.0,
                                useGoogleFonts: GoogleFonts
                                    .asMap()
                                    .containsKey(
                                    FlutterFlowTheme.of(
                                        context)
                                        .displaySmallFamily),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        16.0, 16.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 0.0),
                            child: Text(
                              "Identificación: ${data['uid']}",
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                fontFamily:
                                FlutterFlowTheme.of(context)
                                    .displaySmallFamily,
                                fontSize: 16.0,
                                useGoogleFonts: GoogleFonts
                                    .asMap()
                                    .containsKey(
                                    FlutterFlowTheme.of(
                                        context)
                                        .displaySmallFamily),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        12.0, 12.0, 12.0, 0),
                    child: InkWell(
                      onTap: (){
                        List particpantRef = data['participants'];
                        if(!particpantRef.contains(currentUserReference)){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowTicketList3(sorteo: data,)));
                        }
                        else{
                          Fluttertoast.showToast(msg: "Ya estas participando");
                        }
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x55000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                formatNumber(
                                  data['value'],
                                  formatType:
                                  FormatType.decimal,
                                  decimalType:
                                  DecimalType.automatic,
                                  currency: '€',
                                ),
                                style: FlutterFlowTheme.of(
                                    context)
                                    .titleMedium
                                    .override(
                                  fontFamily:
                                  'Montserrat',
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight:
                                  FontWeight.w500,
                                  useGoogleFonts: GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      FlutterFlowTheme.of(
                                          context)
                                          .titleMediumFamily),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text("Participar",style: TextStyle(
                                  color: FlutterFlowTheme.of(context).accent3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(child: Text("No Data"),);
        },
      ),
    );
  }
}
