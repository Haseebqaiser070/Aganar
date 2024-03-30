import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/success_image/success_image_widget.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'custom_alert_stripe_model.dart';
export 'custom_alert_stripe_model.dart';
import 'dart:math' as math;

class CustomAlertStripeWidget extends StatefulWidget {
  const CustomAlertStripeWidget({
    Key? key,
    this.sorteoAddUser,
    this.title,
    this.body,
  }) : super(key: key);

  final DocumentReference? sorteoAddUser;
  final String? title;
  final String? body;

  @override
  _CustomAlertStripeWidgetState createState() =>
      _CustomAlertStripeWidgetState();
}

class _CustomAlertStripeWidgetState extends State<CustomAlertStripeWidget>
    with TickerProviderStateMixin {
  late CustomAlertStripeModel _model;


  //Winner Prize list
  List<String> prizes = ["Television", "Cash", "Mobile","Computer"];

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomAlertStripeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 8.0,
        ),
        child: StreamBuilder<List<SelectedTicketsRecord>>(
          stream: querySelectedTicketsRecord(
            parent: widget.sorteoAddUser,
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 26.0,
                  height: 26.0,
                  child: SpinKitDoubleBounce(
                    color: FlutterFlowTheme.of(context).primary,
                    size: 26.0,
                  ),
                ),
              );
            }
            List<SelectedTicketsRecord> overlaySelectedTicketsRecordList =
                snapshot.data!;
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0x98101213),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 16.0),
                      child: StreamBuilder<SorteosRecord>(
                        stream:
                            SorteosRecord.getDocument(widget.sorteoAddUser!),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 26.0,
                                height: 26.0,
                                child: SpinKitDoubleBounce(
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 26.0,
                                ),
                              ),
                            );
                          }
                          final profileCardSorteosRecord = snapshot.data!;
                          return Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: 600.0,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 12.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 5.0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: StreamBuilder<List<DBNegocioRecord>>(
                              stream: queryDBNegocioRecord(
                                singleRecord: true,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 26.0,
                                      height: 26.0,
                                      child: SpinKitDoubleBounce(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 26.0,
                                      ),
                                    ),
                                  );
                                }
                                List<DBNegocioRecord>
                                    containerDBNegocioRecordList =
                                    snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container();
                                }
                                final containerDBNegocioRecord =
                                    containerDBNegocioRecordList.isNotEmpty
                                        ? containerDBNegocioRecordList.first
                                        : null;
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x33000000),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Form(
                                    key: _model.formKey,
                                    autovalidateMode: AutovalidateMode.always,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 2.0, 2.0, 2.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 12.0, 16.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            widget.title,
                                                            'Inserte un Titulo',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color: Color(
                                                                    0xFF090F13),
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleMediumFamily),
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 15.0, 16.0, 15.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: AutoSizeText(
                                                      widget.body!,
                                                      maxLines: 2,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium.override(
                                                            fontFamily:
                                                            'Outfit',
                                                            color: FlutterFlowTheme.of(context).grayIcon,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                                .containsKey(
                                                                FlutterFlowTheme.of(context)
                                                                    .titleMediumFamily),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 4.0, 16.0, 12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      if (profileCardSorteosRecord
                                                              .selectedTickets
                                                              .length >=
                                                          profileCardSorteosRecord
                                                              .limiteParticipantes) {
                                                        DocumentReference winnerRef = await getWinner(profileCardSorteosRecord.reference);
                                                        print("this iss the startl.s");
                                                        // DateTime
                                                        //     currentDateTime =
                                                        //     DateTime.now();
                                                        // Add 3 minutes to the current date and time
                                                        // DateTime newDateTime =
                                                        //     currentDateTime.add(
                                                        //         Duration(
                                                        //             minutes:
                                                        //                 3));
                                                        // print(currentDateTime);
                                                        // print(newDateTime);

                                                        print(profileCardSorteosRecord.selectedTickets);
                                                        print("!111");
                                                        //select random prize
                                                        int randomNum = math.Random().nextInt(5);
                                                        print(randomNum);
                                                        print(prizes[randomNum]);
                                                        // update sorteo and turn on timer.
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "sorteos")
                                                            .doc(
                                                                profileCardSorteosRecord
                                                                    .uid)
                                                            .update({
                                                          'timer': true,
                                                          'ganador': winnerRef,
                                                          'prize': prizes[randomNum],
                                                          'timer_end': DateTime.now(),
                                                        });

                                                        print("!222");








                                                        var notificacionesRecordReference =
                                                            NotificacionesRecord
                                                                .collection
                                                                .doc();
                                                        await notificacionesRecordReference
                                                            .set({
                                                          ...createNotificacionesRecordData(
                                                            titulo:
                                                                'Sorteo listo',
                                                            contenido:
                                                                'El sorteo ${profileCardSorteosRecord.nombreSorteo} esta listo!!!',
                                                            createdDate:
                                                                getCurrentTimestamp,
                                                            isCashPayment:
                                                                false,
                                                          ),
                                                          'notifiedUsersList':
                                                              overlaySelectedTicketsRecordList
                                                                  .map((e) =>
                                                                      e.usuario)
                                                                  .withoutNulls
                                                                  .toList(),
                                                        });
                                                        print("!333");
                                                        _model.addNotify =
                                                            NotificacionesRecord
                                                                .getDocumentFromData({
                                                          ...createNotificacionesRecordData(
                                                            titulo:
                                                                'Sorteo listo',
                                                            contenido:
                                                                'El sorteo ${profileCardSorteosRecord.nombreSorteo} esta listo!!!',
                                                            createdDate:
                                                                getCurrentTimestamp,
                                                            isCashPayment:
                                                                false,
                                                          ),
                                                          'notifiedUsersList':
                                                              overlaySelectedTicketsRecordList
                                                                  .map((e) =>
                                                                      e.usuario)
                                                                  .withoutNulls
                                                                  .toList(),
                                                        }, notificacionesRecordReference);
                                                        print("!444");
                                                        triggerPushNotification(
                                                          notificationTitle:
                                                              'Empieza Sorteo',
                                                          notificationText:
                                                              'El sorteo ${profileCardSorteosRecord.nombreSorteo} esta por empezar!!!',
                                                          notificationSound:
                                                              'default',
                                                          userRefs:
                                                              overlaySelectedTicketsRecordList
                                                                  .map((e) =>
                                                                      e.usuario)
                                                                  .withoutNulls
                                                                  .toList(),
                                                          initialPageName:
                                                              'successImage',
                                                          parameterData: {
                                                            'numberSorteo':
                                                                profileCardSorteosRecord
                                                                    .reference,
                                                          },
                                                        );
                                                        print("!555");
                                                        await profileCardSorteosRecord
                                                            .reference
                                                            .update({
                                                          "fecha_sorteo":
                                                          getCurrentTimestamp
                                                        });
                                                        print("!666");
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                SuccessImageWidget(
                                                              numberSorteo:
                                                                  profileCardSorteosRecord
                                                                      .reference,
                                                            ),
                                                          ),
                                                        );
                                                        print("!777");
                                                      } else {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                SuccessImageWidget(
                                                              numberSorteo:
                                                                  profileCardSorteosRecord
                                                                      .reference,
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      setState(() {});
                                                    },
                                                    text: 'Ok',
                                                    options: FFButtonOptions(
                                                      width: 130.0,
                                                      height: 40.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
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
                                                              .primaryBackground,
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
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future getWinner(DocumentReference sorteoRef)async{

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    late DocumentReference winnerRef;
    await firestore.collection("sorteos").doc(sorteoRef.id).collection("selectedTickets").get().then((value){
      winnerRef = value.docs[0].data()['usuario'];
    });
    print("The wiinner is: $winnerRef");
    return winnerRef;
  }
}
