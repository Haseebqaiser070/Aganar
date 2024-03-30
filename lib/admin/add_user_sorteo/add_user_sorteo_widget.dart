import 'package:fluttertoast/fluttertoast.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/custom_alert/custom_alert_widget.dart';
import '/components/custom_alert_general/custom_alert_general_widget.dart';
import '/components/no_users/no_users_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'add_user_sorteo_model.dart';
export 'add_user_sorteo_model.dart';

class AddUserSorteoWidget extends StatefulWidget {
  const AddUserSorteoWidget({
    Key? key,
    this.sorteoAdd,
  }) : super(key: key);

  final DocumentReference? sorteoAdd;

  @override
  _AddUserSorteoWidgetState createState() => _AddUserSorteoWidgetState();
}

class _AddUserSorteoWidgetState extends State<AddUserSorteoWidget> {
  late AddUserSorteoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedAmount = 0;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddUserSorteoModel());

    _model.searchBarController ??= TextEditingController();
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

    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        queryBuilder: (usersRecord) =>
            usersRecord.where('activo', isEqualTo: true),
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
        List<UsersRecord> addUserSorteoUsersRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
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
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Añadir usuario',
                  style: FlutterFlowTheme.of(context).titleLarge,
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: StreamBuilder<SorteosRecord>(
                stream: SorteosRecord.getDocument(widget.sorteoAdd!),
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
                  final containerSorteosRecord = snapshot.data!;
                  return Container(
                    constraints: BoxConstraints(
                      maxWidth: 600.0,
                    ),
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 15.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.searchBarController,
                                    onFieldSubmitted: (_) async {
                                      setState(() {
                                        _model.simpleSearchResults = TextSearch(
                                          addUserSorteoUsersRecordList
                                              .where((e) => e.activo)
                                              .toList()
                                              .map(
                                                (record) => TextSearchItem(
                                                    record, [
                                                  record.email!,
                                                  record.displayName!,
                                                  record.uid!,
                                                  record.phoneNumber!
                                                ]),
                                              )
                                              .toList(),
                                        )
                                            .search(
                                                _model.searchBarController.text)
                                            .map((r) => r.object)
                                            .toList();
                                        ;
                                      });
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Buscar usuario',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .titleSmall,
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodySmall,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .lineColor,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24.0, 24.0, 20.0, 24.0),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 16.0,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                        ),
                                    validator: _model
                                        .searchBarControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_model.searchBarController.text == null ||
                            _model.searchBarController.text == '')
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 0.0, 15.0),
                              child: Builder(
                                builder: (context) {
                                  final userAdded = addUserSorteoUsersRecordList
                                      .map((e) => e)
                                      .toList();
                                  if (userAdded.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width: 300.0,
                                        height: 250.0,
                                        child: NoUsersWidget(),
                                      ),
                                    );
                                  }
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(userAdded.length,
                                          (userAddedIndex) {
                                        final userAddedItem =
                                            userAdded[userAddedIndex];
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
                                                        userAddedItem.photoUrl,
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
                                                            userAddedItem
                                                                .displayName,
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
                                                              userAddedItem
                                                                  .email,
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
                                                              userAddedItem
                                                                  .phoneNumber,
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
                                                      onPressed: userAddedItem
                                                              .misSorteos
                                                              .contains(widget
                                                                  .sorteoAdd)
                                                          ? null
                                                          : () async {
                                                        // Add Participant*****

                                                        FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                        int limiteParticipantes = 0;
                                                        double sorteoPrice = 0;
                                                        int userlength = 0;
                                                        await firestore.collection("sorteos").doc(containerSorteosRecord.uid).get().then((value)async{
                                                          limiteParticipantes = value.data()!['limite_participantes'];
                                                          sorteoPrice = value.data()!['valor_sorteo'];
                                                          await firestore.collection("sorteos").doc(containerSorteosRecord.uid).collection("selectedTickets").get().then((value){
                                                            userlength = value.docs.length;
                                                          });
                                                        });
                                                        print(limiteParticipantes);
                                                        print(userlength);

                                                        if(limiteParticipantes>userlength){
                                                          await enterPayment(sorteoPrice.round());
                                                          if(selectedAmount == 0) return;
                                                          print("enddd");
                                                          await firestore.collection("sorteos").doc(containerSorteosRecord.uid).collection("selectedTickets").doc().set({
                                                            'payment': selectedAmount,
                                                            'usuario': userAddedItem.reference,
                                                          }).then((value){
                                                            print("User Added Successfully.");
                                                          });
                                                          await storePayment(userAddedItem.reference,containerSorteosRecord.reference,selectedAmount,true);
                                                          await userAddedItem
                                                              .reference
                                                              .update({
                                                            'mis_sorteos':
                                                            FieldValue
                                                                .arrayUnion([
                                                              widget
                                                                  .sorteoAdd
                                                            ]),
                                                          });

                                                          var notificacionesRecordReference =
                                                          NotificacionesRecord
                                                              .collection
                                                              .doc();
                                                          await notificacionesRecordReference
                                                              .set({
                                                            ...createNotificacionesRecordData(
                                                              titulo:
                                                              'Elige Tu Emoji',
                                                              contenido:
                                                              'Por favor, elige tu emoji para el sorteo: ${containerSorteosRecord.nombreSorteo}',
                                                              createdDate:
                                                              getCurrentTimestamp,
                                                              isCashPayment:
                                                              true,
                                                              requiredParameter:
                                                              widget
                                                                  .sorteoAdd,
                                                            ),
                                                            'notifiedUsersList':
                                                            [
                                                              userAddedItem
                                                                  .reference
                                                            ],
                                                          });
                                                          _model.emojiNotify =
                                                              NotificacionesRecord
                                                                  .getDocumentFromData({
                                                                ...createNotificacionesRecordData(
                                                                  titulo:
                                                                  'Elige Tu Emoji',
                                                                  contenido:
                                                                  'Por favor, elige tu emoji para el sorteo: ${containerSorteosRecord.nombreSorteo}',
                                                                  createdDate:
                                                                  getCurrentTimestamp,
                                                                  isCashPayment:
                                                                  true,
                                                                  requiredParameter:
                                                                  widget
                                                                      .sorteoAdd,
                                                                ),
                                                                'notifiedUsersList':
                                                                [
                                                                  userAddedItem
                                                                      .reference
                                                                ],
                                                              }, notificacionesRecordReference);
                                                          triggerPushNotification(
                                                            notificationTitle:
                                                            'Elige Tu Emoji',
                                                            notificationText:
                                                            'Elige tu emoji para el sorteo:${containerSorteosRecord.nombreSorteo}',
                                                            notificationSound:
                                                            'default',
                                                            userRefs: [
                                                              userAddedItem
                                                                  .reference
                                                            ],
                                                            initialPageName:
                                                            'notifications',
                                                            parameterData: {},
                                                          );
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                            true,
                                                            backgroundColor:
                                                            Colors
                                                                .transparent,
                                                            enableDrag:
                                                            false,
                                                            context:
                                                            context,
                                                            builder:
                                                                (context) {
                                                              return GestureDetector(
                                                                onTap: () => FocusScope.of(
                                                                    context)
                                                                    .requestFocus(
                                                                    _model.unfocusNode),
                                                                child:
                                                                Padding(
                                                                  padding:
                                                                  MediaQuery.viewInsetsOf(context),
                                                                  child:
                                                                  CustomAlertWidget(
                                                                    title:
                                                                    'Añadir Usuarios',
                                                                    body:
                                                                    'Usuario añadido con exito1',
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value){
                                                            Navigator.pop(context);
                                                          });
                                                        }
                                                        //check again if draw is full
                                                        //   await firestore.collection("sorteos").doc(containerSorteosRecord.uid).get().then((value)async{
                                                        //     limiteParticipantes = value.data()!['limite_participantes'];
                                                        //     await firestore.collection("sorteos").doc(containerSorteosRecord.uid).collection("selectedTickets").get().then((value){
                                                        //       userlength = value.docs.length;
                                                        //     });
                                                        //   });
                                                        //
                                                        //   print("check again");
                                                        //   print(limiteParticipantes);
                                                        //   print(userlength);
                                                        //   if(limiteParticipantes==userlength){
                                                        //     DateTime timerEnd = DateTime.now().add(Duration(minutes: 3));
                                                        //     await firestore.collection("sorteos").doc(containerSorteosRecord.uid).update({
                                                        //       'timer': true,
                                                        //       'timer_end': timerEnd,
                                                        //     }).then((value){
                                                        //       print("Time has been started Successfully.");
                                                        //     });
                                                        // }
                                                        // else{
                                                        //   await showModalBottomSheet(
                                                        //     isScrollControlled:
                                                        //     true,
                                                        //     backgroundColor:
                                                        //     Colors
                                                        //         .transparent,
                                                        //     isDismissible:
                                                        //     false,
                                                        //     enableDrag:
                                                        //     false,
                                                        //     context:
                                                        //     context,
                                                        //     builder:
                                                        //         (context) {
                                                        //       return GestureDetector(
                                                        //         onTap: () => FocusScope.of(
                                                        //             context)
                                                        //             .requestFocus(
                                                        //             _model.unfocusNode),
                                                        //         child:
                                                        //         Padding(
                                                        //           padding:
                                                        //           MediaQuery.viewInsetsOf(context),
                                                        //           child:
                                                        //           CustomAlertGeneralWidget(
                                                        //             title:
                                                        //             'Añadir Usuario',
                                                        //             body:
                                                        //             'El cupo de usuarios para este sorteo esta completo!!!',
                                                        //           ),
                                                        //         ),
                                                        //       );
                                                        //     },
                                                        //   ).then((value) =>
                                                        //       setState(
                                                        //               () {}));
                                                        // }

                                                              _model.selectedTicketsCount =
                                                                  await querySelectedTicketsRecordCount(
                                                                parent:
                                                                    containerSorteosRecord
                                                                        .reference,
                                                              );
                                                              if (_model
                                                                      .selectedTicketsCount! >=
                                                                  containerSorteosRecord
                                                                      .limiteParticipantes) {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  isDismissible:
                                                                      false,
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap: () => FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              _model.unfocusNode),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            CustomAlertGeneralWidget(
                                                                          title:
                                                                              'Añadir Usuario',
                                                                          body:
                                                                              'El cupo de usuarios para este sorteo esta completo!!!',
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    setState(
                                                                        () {}));
                                                              }

                                                              else {
                                                                // await enterPayment(containerSorteosRecord.valorSorteo.round());
                                                                // var selectedTicketsRecordReference =
                                                                //     SelectedTicketsRecord
                                                                //         .createDoc(
                                                                //             widget.sorteoAdd!);
                                                                // await selectedTicketsRecordReference
                                                                //     .set(
                                                                //         createSelectedTicketsRecordData(
                                                                //   usuario:
                                                                //       userAddedItem
                                                                //           .reference,
                                                                // ));
                                                                // _model.cashPaymentUser =
                                                                //     SelectedTicketsRecord.getDocumentFromData(
                                                                //       {
                                                                //         "usuario":
                                                                //         userAddedItem.reference,
                                                                //         'payment': selectedAmount,
                                                                //       },
                                                                //         // createSelectedTicketsRecordData(
                                                                //         //   usuario:
                                                                //         //       userAddedItem.reference,
                                                                //         //   'payment': selectedAmount,
                                                                //         // ),
                                                                //         selectedTicketsRecordReference);

                                                                await userAddedItem
                                                                    .reference
                                                                    .update({
                                                                  'mis_sorteos':
                                                                      FieldValue
                                                                          .arrayUnion([
                                                                    widget
                                                                        .sorteoAdd
                                                                  ]),
                                                                });

                                                                var notificacionesRecordReference =
                                                                    NotificacionesRecord
                                                                        .collection
                                                                        .doc();
                                                                await notificacionesRecordReference
                                                                    .set({
                                                                  ...createNotificacionesRecordData(
                                                                    titulo:
                                                                        'Elige Tu Emoji',
                                                                    contenido:
                                                                        'Por favor, elige tu emoji para el sorteo: ${containerSorteosRecord.nombreSorteo}',
                                                                    createdDate:
                                                                        getCurrentTimestamp,
                                                                    isCashPayment:
                                                                        true,
                                                                    requiredParameter:
                                                                        widget
                                                                            .sorteoAdd,
                                                                  ),
                                                                  'notifiedUsersList':
                                                                      [
                                                                    userAddedItem
                                                                        .reference
                                                                  ],
                                                                });
                                                                _model.emojiNotify =
                                                                    NotificacionesRecord
                                                                        .getDocumentFromData({
                                                                  ...createNotificacionesRecordData(
                                                                    titulo:
                                                                        'Elige Tu Emoji',
                                                                    contenido:
                                                                        'Por favor, elige tu emoji para el sorteo: ${containerSorteosRecord.nombreSorteo}',
                                                                    createdDate:
                                                                        getCurrentTimestamp,
                                                                    isCashPayment:
                                                                        true,
                                                                    requiredParameter:
                                                                        widget
                                                                            .sorteoAdd,
                                                                  ),
                                                                  'notifiedUsersList':
                                                                      [
                                                                    userAddedItem
                                                                        .reference
                                                                  ],
                                                                }, notificacionesRecordReference);
                                                                triggerPushNotification(
                                                                  notificationTitle:
                                                                      'Elige Tu Emoji',
                                                                  notificationText:
                                                                      'Elige tu emoji para el sorteo:${containerSorteosRecord.nombreSorteo}',
                                                                  notificationSound:
                                                                      'default',
                                                                  userRefs: [
                                                                    userAddedItem
                                                                        .reference
                                                                  ],
                                                                  initialPageName:
                                                                      'notifications',
                                                                  parameterData: {},
                                                                );
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap: () => FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              _model.unfocusNode),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            CustomAlertWidget(
                                                                          title:
                                                                              'Añadir Usuarios',
                                                                          body:
                                                                              'Usuario añadido con exito2',
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    setState(
                                                                        () {}));
                                                              }

                                                              setState(() {});

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
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        if (_model.searchBarController.text != null &&
                            _model.searchBarController.text != '')
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 0.0, 15.0),
                              child: Builder(
                                builder: (context) {
                                  final userAddedSearch = _model
                                      .simpleSearchResults
                                      .map((e) => e)
                                      .toList();
                                  if (userAddedSearch.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width: 300.0,
                                        height: 250.0,
                                        child: NoUsersWidget(),
                                      ),
                                    );
                                  }
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children:
                                          List.generate(userAddedSearch.length,
                                              (userAddedSearchIndex) {
                                        final userAddedSearchItem =
                                            userAddedSearch[
                                                userAddedSearchIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 8.0, 16.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 120.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 8.0, 8.0, 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      valueOrDefault<String>(
                                                        userAddedSearchItem
                                                            .photoUrl,
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
                                                            userAddedSearchItem
                                                                .displayName,
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
                                                              userAddedSearchItem
                                                                  .email,
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
                                                              userAddedSearchItem
                                                                  .phoneNumber,
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
                                                      onPressed:
                                                          userAddedSearchItem
                                                                  .misSorteos
                                                                  .contains(widget
                                                                      .sorteoAdd)
                                                              ? null
                                                              : () async {
                                                                  _model.selectedTicketsCountSeek =
                                                                      await querySelectedTicketsRecordCount(
                                                                    parent: containerSorteosRecord
                                                                        .reference,
                                                                  );
                                                                  if (_model
                                                                          .selectedTicketsCountSeek ==
                                                                      containerSorteosRecord
                                                                          .limiteParticipantes) {
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      isDismissible:
                                                                          false,
                                                                      enableDrag:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return GestureDetector(
                                                                          onTap: () =>
                                                                              FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                MediaQuery.viewInsetsOf(context),
                                                                            child:
                                                                                CustomAlertGeneralWidget(
                                                                              title: 'Añadir usuarios',
                                                                              body: 'El cupo de usuarios para este sorteo esta completo!!!',
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  } else {
                                                                    var selectedTicketsRecordReference =
                                                                        SelectedTicketsRecord.createDoc(
                                                                            widget.sorteoAdd!);
                                                                    await selectedTicketsRecordReference
                                                                        .set(
                                                                            createSelectedTicketsRecordData(
                                                                      usuario:
                                                                          userAddedSearchItem
                                                                              .reference,
                                                                    ));
                                                                    _model.cashPaymentUserSeek =
                                                                        SelectedTicketsRecord.getDocumentFromData(
                                                                            createSelectedTicketsRecordData(
                                                                              usuario: userAddedSearchItem.reference,
                                                                            ),
                                                                            selectedTicketsRecordReference);

                                                                    await userAddedSearchItem
                                                                        .reference
                                                                        .update({
                                                                      'mis_sorteos':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        widget
                                                                            .sorteoAdd
                                                                      ]),
                                                                    });

                                                                    var notificacionesRecordReference =
                                                                        NotificacionesRecord
                                                                            .collection
                                                                            .doc();
                                                                    await notificacionesRecordReference
                                                                        .set({
                                                                      ...createNotificacionesRecordData(
                                                                        titulo:
                                                                            'Elige Tu Emoji',
                                                                        contenido:
                                                                            'Por favor, elige tu emoji para el sorteo: ${containerSorteosRecord.nombreSorteo}',
                                                                        createdDate:
                                                                            getCurrentTimestamp,
                                                                        isCashPayment:
                                                                            true,
                                                                        requiredParameter:
                                                                            widget.sorteoAdd,
                                                                      ),
                                                                      'notifiedUsersList':
                                                                          [
                                                                        userAddedSearchItem
                                                                            .reference
                                                                      ],
                                                                    });
                                                                    _model.emojiNotifySeek =
                                                                        NotificacionesRecord
                                                                            .getDocumentFromData({
                                                                      ...createNotificacionesRecordData(
                                                                        titulo:
                                                                            'Elige Tu Emoji',
                                                                        contenido:
                                                                            'Por favor, elige tu emoji para el sorteo: ${containerSorteosRecord.nombreSorteo}',
                                                                        createdDate:
                                                                            getCurrentTimestamp,
                                                                        isCashPayment:
                                                                            true,
                                                                        requiredParameter:
                                                                            widget.sorteoAdd,
                                                                      ),
                                                                      'notifiedUsersList':
                                                                          [
                                                                        userAddedSearchItem
                                                                            .reference
                                                                      ],
                                                                    }, notificacionesRecordReference);
                                                                    triggerPushNotification(
                                                                      notificationTitle:
                                                                          'Elige Tu Emoji',
                                                                      notificationText:
                                                                          'Elige tu emoji para el sorteo:${containerSorteosRecord.nombreSorteo}',
                                                                      notificationSound:
                                                                          'default',
                                                                      userRefs: [
                                                                        userAddedSearchItem
                                                                            .reference
                                                                      ],
                                                                      initialPageName:
                                                                          'selectEmojiEfectivo',
                                                                      parameterData: {
                                                                        'sorteo':
                                                                            widget.sorteoAdd,
                                                                      },
                                                                    );
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      enableDrag:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return GestureDetector(
                                                                          onTap: () =>
                                                                              FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                MediaQuery.viewInsetsOf(context),
                                                                            child:
                                                                                CustomAlertWidget(
                                                                              title: 'Añadir Usuarios',
                                                                              body: 'Usuario añadido con exito3',
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }

                                                                  setState(
                                                                      () {});
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
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
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
                                      }),
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
          ),
        );
      },
    );
  }

  enterPayment(int price){
    List<int> possibleAmounts = [];
    for(int i =1; i<=10; i++){
      possibleAmounts.add(price*i);
    }
    return showModalBottomSheet(context: context, builder: (context){
      return Container(
        height: 300,
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        child: Column(
          children: [
            Text("Engresa la cantidad de emojis",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),),
            SizedBox(height: 10,),
            SizedBox(
              height: 200,
              child: GridView.count(
                crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 5,
                children: possibleAmounts.map((e){
                  return amountButton(e, (){
                    selectedAmount = e;
                    Navigator.pop(context);
                  });
                }).toList(),
              ),
            ),
            // TextFormField(
            //   validator: (v){
            //     if(v == "" || v == null){
            //       return "Please Enter Price";
            //     }
            //     if(int.parse(v) < price){
            //       return "El monto mínimo del sorteo es $price";
            //     }
            //   },
            //   controller: amountC,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     hintText: "Enter Amount.",
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide.none,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10,),
            // InkWell(
            //   onTap: (){
            //     if(formKey.currentState!.validate()){
            //     Navigator.pop(context);
            //     }
            //   },
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            //     decoration: BoxDecoration(
            //         color: FlutterFlowTheme.of(
            //             context)
            //             .primary,
            //         borderRadius: BorderRadius.circular(10)
            //     ),
            //     alignment: Alignment.center,
            //     child: Text("Agregar",style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold
            //     ),),
            //   ),
            // ),
          ],
        ),
      );
    });
  }


  Future storePayment(DocumentReference userRef,DocumentReference ruffelRef,int amount,bool isParticipate)async{
    print("payment saving..");
    Map<String,dynamic> paymentModel = {
      'userRef': userRef,
      'ruffelRef': ruffelRef,
      'amount': amount,
      'isParticipate': isParticipate,
      'createdAt': FieldValue.serverTimestamp(),
    };
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("payments").add(paymentModel).then((value){
      print("payment store successfull");
    }).catchError((e){
      print("errorr: $e");
    });
  }

  Widget amountButton(int amount, Function() fnc){
    return InkWell(
      onTap: fnc,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: FlutterFlowTheme.of(
              context)
              .secondaryBackground,
          boxShadow: [
            BoxShadow(color: Colors.white12,offset: Offset(2,2), blurRadius: 5,spreadRadius: 4)
          ]
        ),
        alignment: Alignment.center,
        child: Text("€$amount",style: TextStyle(
          color: Colors.white
        ),),
      ),
    );
  }
}
