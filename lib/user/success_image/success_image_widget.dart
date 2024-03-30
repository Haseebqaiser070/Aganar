import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/inicio/inicio_widget.dart';
import '/user/notifications/notifications_widget.dart';
import '/user/sorteo_v2/sorteo_v2_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'success_image_model.dart';
export 'success_image_model.dart';

class SuccessImageWidget extends StatefulWidget {
  const SuccessImageWidget({
    Key? key,
    this.numberSorteo,
  }) : super(key: key);

  final DocumentReference? numberSorteo;

  @override
  _SuccessImageWidgetState createState() => _SuccessImageWidgetState();
}

class _SuccessImageWidgetState extends State<SuccessImageWidget> {
  late SuccessImageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuccessImageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.consultarTickets = await querySelectedTicketsRecordOnce(
        parent: widget.numberSorteo,
        queryBuilder: (selectedTicketsRecord) => selectedTicketsRecord
            .where('usuario', isEqualTo: currentUserReference),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.consultarTickets?.imagen == null ||
          _model.consultarTickets?.imagen == '') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationsWidget(),
          ),
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<SelectedTicketsRecord>>(
      stream: querySelectedTicketsRecord(
        parent: widget.numberSorteo,
        queryBuilder: (selectedTicketsRecord) => selectedTicketsRecord
            .where('usuario', isEqualTo: currentUserReference),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 26.0,
                height: 26.0,
                child: SpinKitDoubleBounce(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 26.0,
                ),
              ),
            ),
          );
        }
        List<SelectedTicketsRecord> successImageSelectedTicketsRecordList =
            snapshot.data!;
        final successImageSelectedTicketsRecord =
            successImageSelectedTicketsRecordList.isNotEmpty
                ? successImageSelectedTicketsRecordList.first
                : null;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: StreamBuilder<SorteosRecord>(
              stream: SorteosRecord.getDocument(widget.numberSorteo!),
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
                final columnSorteosRecord = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 60.0,
                            fillColor: FlutterFlowTheme.of(context).lineColor,
                            icon: Icon(
                              Icons.close_rounded,
                              color: FlutterFlowTheme.of(context).grayIcon,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InicioWidget(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: FlutterFlowTheme.of(context).primary,
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              30.0, 30.0, 30.0, 30.0),
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 60.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Text(
                        'Que guay!\nEstas participando',
                        textAlign: TextAlign.center,
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).accent3,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .displaySmallFamily),
                                ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Text(
                        'Tu emoji es: ${successImageSelectedTicketsRecord!.imagen}',
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //       children: successImageSelectedTicketsRecord!.imagen.map((e){
                    //         return Text(" $e ",style: FlutterFlowTheme.of(context).titleMedium,);
                    //       }).toList(),
                    //   ),
                    // ),
                    Container(
                      width: 400.0,
                      decoration: BoxDecoration(
                        // color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 8.0, 24.0, 0.0),
                              child: Text(
                                'Recuerda que antes de iniciar el sorteo, debemos esperar a que todos los participantes ocupen los cupos disponibles. Te informaremos en cuanto comience el sorteo.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodySmallFamily),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Container(
                        width: 300.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 0.0, 0.0),
                              child: Image.network(
                                valueOrDefault<String>(
                                  columnSorteosRecord.imagenRef,
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ruleta-izygr8/assets/cxevpu3ehmno/ruleta-removebg-preview-transformed_(1).png',
                                ),
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 4.0),
                                    child: AutoSizeText(
                                      columnSorteosRecord.nombreSorteo,
                                      maxLines: 2,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily),
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 4.0),
                                    child: Text(
                                      formatNumber(
                                        columnSorteosRecord.valorSorteo,
                                        formatType: FormatType.decimal,
                                        decimalType: DecimalType.automatic,
                                        currency: '€',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Montserrat',
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 46.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // if(columnSorteosRecord.timer == true)
                            //   Text("${columnSorteosRecord.minute} : ${columnSorteosRecord.second}",),


                            // Text(columnSorteosRecord.selectedTickets.length
                            //     .toString()),
                            //   Text(columnSorteosRecord.limiteParticipantes
                            //       .toString() ),
                            //
                            // if (columnSorteosRecord.selecte
                            // dTickets.length
                            //         .toString() ==
                            //     columnSorteosRecord.limiteParticipantes
                            //         .toString() && columnSorteosRecord.timer == false )
                            // if(columnSorteosRecord.ganador != null)

                            if(columnSorteosRecord.ganador != null && DateTime.now().compareTo(columnSorteosRecord.timer_end.add(Duration(minutes: 3))) >0)
                              FFButtonWidget(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SorteoV2Widget(
                                        sorteoRuleta: widget.numberSorteo,
                                      ),
                                    ),
                                  );
                                },
                                text: 'Ir al sorteo',
                                icon: FaIcon(
                                  FontAwesomeIcons.gifts,
                                ),
                                options: FFButtonOptions(
                                  width: 230.0,
                                  height: 55.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 10.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: Colors.white,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                      ),
                                  elevation: 1.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
