import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_alert/custom_alert_widget.dart';
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
import 'select_tickets_model.dart';
export 'select_tickets_model.dart';

class SelectTicketsWidget extends StatefulWidget {
  const SelectTicketsWidget({
    Key? key,
    required this.sorteo,
    required this.SelectedTicketRef,
  }) : super(key: key);

  final SorteosRecord? sorteo;
  final SelectedTicketRef;

  @override
  _SelectTicketsWidgetState createState() => _SelectTicketsWidgetState();
}

class _SelectTicketsWidgetState extends State<SelectTicketsWidget> {
  late SelectTicketsModel _model;
  List ticketList = [];
  int selectionLimite = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getselectionLimite()async{
    int sorteoPrice = 0;
    int userPayment = 0;
    await firestore.collection("sorteos").doc(widget.sorteo!.reference.id).get().then((value){
      sorteoPrice = value.data()!['valor_sorteo'].round();
    });
    await firestore.collection("sorteos").doc(widget.sorteo!.reference.id).collection("selectedTickets").where('usuario', isEqualTo: currentUserReference).get().then((value){
      userPayment = value.docs[0].data()['payment'];
    });
    selectionLimite = (userPayment/sorteoPrice).round();
    print("selectionLimite");
    print(userPayment);
    print(sorteoPrice);
    print(selectionLimite);
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    getselectionLimite();
    _model = createModel(context, () => SelectTicketsModel());

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

    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 44.0, 0.0, 0.0),
        child: Container(
          width: double.infinity,
          height: 600.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                color: Color(0x25090F13),
                offset: Offset(0.0, 2.0),
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 5.0),
                              child: Text(
                                'Escoge tu Emoji',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Noto Sans Hebrew',
                                      color:
                                          FlutterFlowTheme.of(context).secondaryBackground,
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
                                  ticketList.length == 0
                                    ? null
                                    : () async {
                                        _model.verifyEmojiStripe =
                                            await querySorteosRecordOnce(
                                          queryBuilder: (sorteosRecord) =>
                                              sorteosRecord.where('uid',
                                                  isEqualTo: widget
                                                      .sorteo?.reference.id),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        if (_model
                                            .verifyEmojiStripe!.selectedTickets
                                            .contains(_model.selectedImage)) {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            isDismissible: false,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: CustomAlertWidget(
                                                  title: 'Seleccionar Emoji',
                                                  body:
                                                      'Este emoji ya no esta disponible, elige otro por favor...',
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        } else {
                                          setState(() {
                                            FFAppState().Boletos = [];
                                          });

                                          // for(String e in ticketList){
                                          //   await widget.sorteo!.reference
                                          //       .update({
                                          //     'selectedTickets':
                                          //     FieldValue.arrayUnion(
                                          //         [e]),
                                          //   });
                                          // }

                                          await widget.sorteo!.reference
                                              .update({
                                            'selectedTickets':
                                                FieldValue.arrayUnion(
                                                    [_model.selectedImage]),
                                          });
                                          _model.ticketFilterCard =
                                              await querySorteosRecordOnce(
                                            queryBuilder: (sorteosRecord) =>
                                                sorteosRecord.where('uid',
                                                    isEqualTo: widget
                                                        .sorteo?.reference.id),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);

                                          // var selectedTicketsRecordReference =
                                          //     SelectedTicketsRecord.createDoc(
                                          //         widget.sorteo!.reference);

                                    widget.SelectedTicketRef
                                              .update(
                                                  createSelectedTicketsRecordData(
                                            imagen: _model.selectedImage,
                                            usuario: currentUserReference,
                                            idBoleto: _model.imageNumber,
                                            numTicket: functions.indiceTicket(
                                                _model.ticketFilterCard!
                                                    .selectedTickets
                                                    .toList(),
                                                // ticketList[0]
                                                _model.selectedImage!
                                            ),
                                          ));
                                          _model.createUserTicket =
                                              SelectedTicketsRecord.getDocumentFromData(
                                                  createSelectedTicketsRecordData(
                                                    imagen: _model.selectedImage,
                                                    usuario:
                                                        currentUserReference,
                                                    idBoleto:
                                                        _model.imageNumber,
                                                    numTicket:
                                                        functions.indiceTicket(
                                                            _model
                                                                .ticketFilterCard!
                                                                .selectedTickets
                                                                .toList(),
                                                            // ticketList[0]
                                                            _model
                                                                .selectedImage!
                                                        ),
                                                  ),
                                                  widget.SelectedTicketRef);
                                          Navigator.pop(context);
                                        }

                                        setState(() {});
                                      },
                                text: 'Elegir Figura',
                                options: FFButtonOptions(
                                  width: 300.0,
                                  height: 50.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontSize: 20.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                  disabledColor:
                                      FlutterFlowTheme.of(context).grayIcon,
                                  disabledTextColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 200.0, 0.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 15.0, 5.0, 15.0),
                                          child: Builder(
                                            builder: (context) {
                                              final listaBoletos = FFAppState()
                                                  .Boletos
                                                  .map((e) => e)
                                                  .toList()
                                                  .where((e) => !widget
                                                      .sorteo!.selectedTickets
                                                      .contains(e))
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
                                                scrollDirection: Axis.vertical,
                                                itemCount: listaBoletos.length,
                                                itemBuilder: (context,
                                                    listaBoletosIndex) {
                                                  final listaBoletosItem = listaBoletos[listaBoletosIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 5.0,
                                                                5.0, 5.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        setState(() {
                                                          if(ticketList.contains(listaBoletosItem)){
                                                            ticketList.removeWhere((element) =>element == listaBoletosItem);
                                                          }
                                                          else if(ticketList.length <selectionLimite){
                                                            ticketList.add(listaBoletosItem);
                                                            _model.selectedImage =
                                                                listaBoletosItem;
                                                            _model.imageNumber =
                                                                listaBoletosIndex;
                                                          }
                                                          //
                                                          // print(_model.selectedImage);
                                                          // print(_model.imageNumber);
                                                          // if(!ticketList.contains(listaBoletosItem) && ticketList.length<10){
                                                          //   ticketList.add(listaBoletosItem);
                                                          //   _model.imageNumber = listaBoletosIndex;
                                                          // }
                                                          // print(ticketList);
                                                          // print(_model.imageNumber);
                                                          // setState(() { });
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 150.0,
                                                        height: 150.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: valueOrDefault<
                                                              Color>(
                                                            ticketList.contains(listaBoletosItem)
                                                            // listaBoletosItem ==
                                                            //         _model
                                                            //             .selectedImage
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
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    fontSize:
                                                                        25.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
