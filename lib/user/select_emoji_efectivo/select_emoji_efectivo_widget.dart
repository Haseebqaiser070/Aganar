import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_alert/custom_alert_widget.dart';
import '/components/custom_alert_efectivo/custom_alert_efectivo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'select_emoji_efectivo_model.dart';
export 'select_emoji_efectivo_model.dart';

class SelectEmojiEfectivoWidget extends StatefulWidget {
  const SelectEmojiEfectivoWidget({
    Key? key,
    required this.sorteo,
  }) : super(key: key);

  final DocumentReference? sorteo;

  @override
  _SelectEmojiEfectivoWidgetState createState() =>
      _SelectEmojiEfectivoWidgetState();
}

class _SelectEmojiEfectivoWidgetState extends State<SelectEmojiEfectivoWidget> {
  late SelectEmojiEfectivoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> emojiList = [];
  int selectionLimite = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getselectionLimite()async{
    int sorteoPrice = 0;
    int userPayment = 0;
    await firestore.collection("sorteos").doc(widget.sorteo!.id).get().then((value){
      sorteoPrice = value.data()!['valor_sorteo'].round();
    });
    await firestore.collection("sorteos").doc(widget.sorteo!.id).collection("selectedTickets").where('usuario', isEqualTo: currentUserReference).get().then((value){
      userPayment = value.docs[0].data()['payment'];
    });
    selectionLimite = (userPayment/sorteoPrice).round();
    print("selectionLimite");
    print(userPayment);
    print(sorteoPrice);
    print(selectionLimite);
  }

  @override
  void initState() {
    super.initState();
    getselectionLimite();
    _model = createModel(context, () => SelectEmojiEfectivoModel());

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
        parent: widget.sorteo,
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
        List<SelectedTicketsRecord>
            selectEmojiEfectivoSelectedTicketsRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final selectEmojiEfectivoSelectedTicketsRecord =
            selectEmojiEfectivoSelectedTicketsRecordList.isNotEmpty
                ? selectEmojiEfectivoSelectedTicketsRecordList.first
                : null;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: Color(0x007237ED),
              automaticallyImplyLeading: false,
              title: Text(
                'Elije un Emoji',
                style: FlutterFlowTheme.of(context).titleLarge,
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: StreamBuilder<SorteosRecord>(
                stream: SorteosRecord.getDocument(widget.sorteo!),
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
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 20.0, 16.0, 5.0),
                                    child: Text(
                                      'Escoge tu Emoji',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Sans Hebrew',
                                            color: FlutterFlowTheme.of(context)
                                                .accent3,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 15.0, 0.0),
                                    child: AutoSizeText(
                                      'Elige un emoji de la lista disponible para representar a tu mascota en este sorteo',
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 15.0, 15.0, 20.0),
                                    child: FFButtonWidget(
                                      onPressed:
                                      // _model.selectedImage == null ||
                                      //         _model.selectedImage == ''
                                      emojiList.length == 0
                                          ? null
                                          : () async {
                                              _model.verifyEmojiCash =
                                                  await querySorteosRecordOnce(
                                                queryBuilder: (sorteosRecord) =>
                                                    sorteosRecord.where('uid',
                                                        isEqualTo:
                                                            widget.sorteo?.id),
                                                singleRecord: true,
                                              ).then((s) => s.firstOrNull);
                                              if (_model.verifyEmojiCash!
                                                  .selectedTickets
                                                  .contains(
                                                      _model.selectedImage)) {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  isDismissible: false,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () => FocusScope
                                                              .of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            CustomAlertWidget(
                                                          title:
                                                              'Seleccionar Emoji',
                                                          body:
                                                              'Este emoji ya no esta disponible, elige otro por favor...',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                    (value) => setState(() {}));
                                              } else {
                                                setState(() {
                                                  FFAppState().Boletos = [];
                                                });

                                                await columnSorteosRecord
                                                    .reference
                                                    .update({
                                                  'selectedTickets':
                                                      FieldValue.arrayUnion([
                                                    _model.selectedImage
                                                  ]),
                                                });
                                                _model.ticketFilterCash =
                                                    await querySorteosRecordOnce(
                                                  queryBuilder: (sorteosRecord) =>
                                                      sorteosRecord.where('uid',
                                                          isEqualTo:
                                                              columnSorteosRecord
                                                                  .reference
                                                                  .id),
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);

                                                await selectEmojiEfectivoSelectedTicketsRecord!
                                                    .reference
                                                    .update(
                                                        createSelectedTicketsRecordData(
                                                  imagen: _model.selectedImage,
                                                  idBoleto: _model.imageNumber,
                                                  numTicket:
                                                      functions.indiceTicket(
                                                          _model
                                                              .ticketFilterCash!
                                                              .selectedTickets
                                                              .toList(),
                                                          _model
                                                              .selectedImage!),
                                                ));
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () => FocusScope
                                                              .of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode),

                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            CustomAlertEfectivoWidget(
                                                          sorteoAddUser:
                                                              columnSorteosRecord
                                                                  .reference,
                                                          title: 'Registro',
                                                          body:
                                                              'Ya estas participando',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                    (value) {
                                                      FirebaseFirestore.instance.collection("sorteos").doc(columnSorteosRecord.reference.id).collection("selectedTickets").get().then((value)async{
                                                        print("check1");
                                                        print(value.docs.length);
                                                        print(columnSorteosRecord.selectedTickets.length);
                                                        print(columnSorteosRecord.limiteParticipantes);
                                                        if(value.docs.length >= columnSorteosRecord.limiteParticipantes && columnSorteosRecord.selectedTickets.length+1 >= columnSorteosRecord.limiteParticipantes){
                                                          print("check2");
                                                          DocumentReference winnerRef = await getWinner(columnSorteosRecord.reference);
                                                          await columnSorteosRecord
                                                              .reference
                                                              .update({
                                                            'estado_sorteo': true,
                                                            'timer': true,
                                                            'ganador': winnerRef,
                                                            'timer_end': DateTime.now(),
                                                          });
                                                        }
                                                      });
                                                      setState(() {

                                                      });
                                                    });
                                              }

                                              setState(() {});
                                            },
                                      text: 'Elegir Figura',
                                      options: FFButtonOptions(
                                        width: 300.0,
                                        height: 50.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent3,
                                              fontSize: 20.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily),
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        disabledColor:
                                            FlutterFlowTheme.of(context)
                                                .grayIcon,
                                        disabledTextColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 200.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      5.0, 15.0, 5.0, 15.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final listaBoletos =
                                                      FFAppState()
                                                          .Boletos
                                                          .where((e) =>
                                                              !valueOrDefault<
                                                                  bool>(
                                                                columnSorteosRecord
                                                                    .selectedTickets
                                                                    .contains(
                                                                        valueOrDefault<
                                                                            String>(
                                                                  e,
                                                                  'null',
                                                                )),
                                                                true,
                                                              ))
                                                          .toList();
                                                  return GridView.builder(
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 5,
                                                      crossAxisSpacing: 1.0,
                                                      mainAxisSpacing: 10.0,
                                                      childAspectRatio: 1.0,
                                                    ),
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        listaBoletos.length,
                                                    itemBuilder: (context,
                                                        listaBoletosIndex) {
                                                      final listaBoletosItem =
                                                          listaBoletos[
                                                              listaBoletosIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    5.0,
                                                                    5.0,
                                                                    5.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            // emojiList.clear();
                                                            if(emojiList.contains(listaBoletosItem)){
                                                              emojiList.removeWhere((element) => element == listaBoletosItem);
                                                              setState(() {

                                                              });
                                                            }
                                                            else if(emojiList.length <selectionLimite){
                                                              emojiList.add(listaBoletosItem);
                                                              setState(() {
                                                                _model.selectedImage =
                                                                    listaBoletosItem;
                                                                _model.imageNumber =
                                                                    listaBoletosIndex;
                                                              });
                                                            }
                                                          },
                                                          child: Container(
                                                            width: 150.0,
                                                            height: 150.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                // listaBoletosItem ==
                                                                //         _model
                                                                //             .selectedImage
                                                                    emojiList.contains(listaBoletosItem)
                                                                        ? Color(
                                                                        0xADFCDC0C)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 2.0,
                                                              ),
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            5.0,
                                                                            5.0,
                                                                            5.0),
                                                                child: Text(
                                                                  listaBoletosItem,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        fontSize:
                                                                            25.0,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
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
