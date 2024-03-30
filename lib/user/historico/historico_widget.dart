import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/nav_bar_floting/nav_bar_floting_widget.dart';
import '/components/no_data/no_data_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/user/inicio/inicio_widget.dart';
import '/user/success_image/success_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'historico_model.dart';
export 'historico_model.dart';

class HistoricoWidget extends StatefulWidget {
  const HistoricoWidget({
    Key? key,
    this.misSorteos,
  }) : super(key: key);

  final SorteosRecord? misSorteos;

  @override
  _HistoricoWidgetState createState() => _HistoricoWidgetState();
}

class _HistoricoWidgetState extends State<HistoricoWidget>
    with TickerProviderStateMixin {
  late HistoricoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // List<Map<String,dynamic>> sorteoList = [];

  // Future<List<Map<String,dynamic>>> getUserSorteos()async{
  //   for(DocumentReference documentReference in currentUserDocument!.misSorteos){
  //     await firestore.collection("sorteos").doc(documentReference.id).get().then((value){
  //       if(value.data() != null){
  //         sorteoList.add(value.data()!);
  //       }
  //     });
  //   }
  //   return sorteoList;
  // }


  var items = [
    'Emoji ganador',
    'Cuenta regresive',
    'Elige tu numero de la suerte',
    'Sorteo privado',
  ];

  String dorpDownValue = "Emoji ganador";

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoricoModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
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
    // return Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: Size.fromHeight(70.0),
    //     child: AppBar(
    //       backgroundColor:
    //       FlutterFlowTheme.of(context).primaryBackground,
    //       automaticallyImplyLeading: false,
    //       title: Padding(
    //         padding:
    //         EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
    //         child: Row(
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             if (valueOrDefault<bool>(
    //                 currentUserDocument?.isAdmin, false))
    //               FlutterFlowIconButton(
    //                 borderColor: Colors.transparent,
    //                 borderRadius: 30.0,
    //                 borderWidth: 1.0,
    //                 buttonSize: 60.0,
    //                 icon: Icon(
    //                   Icons.arrow_back_rounded,
    //                   color: FlutterFlowTheme.of(context).grayIcon,
    //                   size: 30.0,
    //                 ),
    //                 onPressed: () async {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => InicioWidget(),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             Text(
    //               'Histórico de sorteos',
    //               style: FlutterFlowTheme.of(context).titleLarge,
    //             ),
    //           ],
    //         ),
    //       ),
    //       actions: [],
    //       centerTitle: false,
    //       elevation: 0.0,
    //     ),
    //   ),
    //   body: FutureBuilder(
    //     future: getUserSorteos(),
    //     builder: (context, snapshot){
    //       if(snapshot.connectionState == ConnectionState.waiting){
    //         return Center(child: Text("Loading"),);
    //       }
    //       if(snapshot.connectionState == ConnectionState.done){
    //         if(snapshot.data == null){
    //           return Center(child: Text("No data"),);
    //         }
    //         return ListView(
    //           children: snapshot.data!.map((e){
    //             return Text("sd");
    //           }).toList(),
    //         );
    //       }
    //
    //       return Center(child: Text("No data"),);
    //
    //     },
    //   ),
    //
    // );

    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<SorteosRecord>>(
        stream: currentUserDocument!.misSorteos.length > 10?
        querySorteosRecord(
            queryBuilder: (sorteosRecord) => sorteosRecord.whereIn(
                'uid',
                (currentUserDocument?.misSorteos?.toList().sublist(currentUserDocument!.misSorteos.length-10) ?? [])
                    .map((e) => valueOrDefault<String>(
                  e.id,
                  'null',
                ))
                    .toList() !=
                    ''
                    ? (currentUserDocument?.misSorteos?.toList().sublist(currentUserDocument!.misSorteos.length-10) ?? [])
                    .map((e) => valueOrDefault<String>(
                  e.id,
                  'null',
                ))
                    .toList()
                    : null)
        )
            :
        querySorteosRecord(
          queryBuilder: (sorteosRecord) => sorteosRecord.whereIn(
              'uid',
              (currentUserDocument?.misSorteos?.toList() ?? [])
                          .map((e) => valueOrDefault<String>(
                                e.id,
                                'null',
                              ))
                          .toList() !=
                      ''
                  ? (currentUserDocument?.misSorteos?.toList() ?? [])
                      .map((e) => valueOrDefault<String>(
                            e.id,
                            'null',
                          ))
                      .toList()
                  : null)
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
          List<SorteosRecord> historicoSorteosRecordList = snapshot.data!;
          return GestureDetector(
            onTap: () =>
                FocusScope.of(context).requestFocus(_model.unfocusNode),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70.0),
                child: AppBar(
                  backgroundColor:
                      FlutterFlowTheme.of(context).primaryBackground,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (valueOrDefault<bool>(
                            currentUserDocument?.isAdmin, false))
                          FlutterFlowIconButton(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InicioWidget(),
                                ),
                              );
                            },
                          ),
                        Text(
                          'Histórico de sorteos',
                          style: FlutterFlowTheme.of(context).titleLarge,
                        ),
                      ],
                    ),
                  ),
                  actions: [],
                  centerTitle: false,
                  elevation: 0.0,
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 10, right: 10, bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'seleccionar sorteo',
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'Noto Sans Hebrew',
                              useGoogleFonts: GoogleFonts.asMap()
                                  .containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                          ),
                        ),
                        DropdownButton(
                          value: dorpDownValue,
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items,style: TextStyle(
                                  color: Colors.white
                              ),),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if(value != null){
                              setState(() {
                                dorpDownValue = value;
                              });
                            }
                          },
                          dropdownColor: FlutterFlowTheme.of(context).secondaryBackground,
                          iconEnabledColor: Colors.white,
                          underline: SizedBox(),
                        ),
                      ],
                    ),
                  ),

                  if(dorpDownValue == "Emoji ganador")
                  Expanded(
                    child: SafeArea(
                      top: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: StreamBuilder<List<SelectedTicketsRecord>>(
                              stream: querySelectedTicketsRecord(
                                queryBuilder: (selectedTicketsRecord) =>
                                    selectedTicketsRecord.where('usuario',
                                        isEqualTo: currentUserReference),
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
                                List<SelectedTicketsRecord>
                                containerSelectedTicketsRecordList =
                                snapshot.data!;
                                return Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 600.0,
                                  ),
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment(0.0, 0),
                                          child: TabBar(
                                            labelColor:
                                            FlutterFlowTheme.of(context).accent3,
                                            unselectedLabelColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            labelStyle: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                fontFamily: 'Montserrat',
                                                useGoogleFonts: GoogleFonts.asMap()
                                                    .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily),
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ),
                                            unselectedLabelStyle: TextStyle(
                                                fontWeight: FontWeight.w500
                                            ),
                                            indicatorColor:
                                            FlutterFlowTheme.of(context).accent3,
                                            tabs: [
                                              Tab(
                                                text: 'En curso',
                                              ),
                                              Tab(
                                                text: 'Pasados',
                                              ),
                                            ],
                                            controller: _model.tabBarController,
                                            onTap: (value) => setState(() {}),
                                          ),
                                        ),
                                        Expanded(
                                          child: TabBarView(
                                            controller: _model.tabBarController,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 12.0, 0.0, 12.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final actuales =
                                                          historicoSorteosRecordList
                                                              .where((e) =>
                                                          !valueOrDefault<
                                                              bool>(
                                                            e.jugoSorteo
                                                                .contains(
                                                                currentUserReference),
                                                            true,
                                                          ))
                                                              .toList();
                                                          if (actuales.isEmpty) {
                                                            return Center(
                                                              child: Container(
                                                                width: 300.0,
                                                                height: 250.0,
                                                                child: NoDataWidget(),
                                                              ),
                                                            );
                                                          }
                                                          return ListView.builder(
                                                            padding: EdgeInsets.zero,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                            Axis.vertical,
                                                            itemCount:
                                                            actuales.length,
                                                            itemBuilder: (context,
                                                                actualesIndex) {
                                                              final actualesItem =
                                                              actuales[
                                                              actualesIndex];
                                                              return Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    8.0),
                                                                child: InkWell(
                                                                  splashColor: Colors
                                                                      .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  onTap: () async {
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                            SuccessImageWidget(
                                                                              numberSorteo:
                                                                              actualesItem
                                                                                  .reference,
                                                                            ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .secondaryBackground,
                                                                      // boxShadow: [
                                                                      //   BoxShadow(
                                                                      //     blurRadius:
                                                                      //     4.0,
                                                                      //     color: Color(
                                                                      //         0x520E151B),
                                                                      //     offset:
                                                                      //     Offset(
                                                                      //         0.0,
                                                                      //         2.0),
                                                                      //   )
                                                                      // ],
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          8.0),
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
                                                                    child: Padding(
                                                                      padding:
                                                                      EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          8.0,
                                                                          8.0,
                                                                          8.0,
                                                                          8.0),
                                                                      child: Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                            BorderRadius.circular(
                                                                                6.0),
                                                                            child:
                                                                            Image
                                                                                .network(
                                                                              actualesItem
                                                                                  .imagenRef,
                                                                              width:
                                                                              80.0,
                                                                              height:
                                                                              80.0,
                                                                              fit: BoxFit
                                                                                  .cover,
                                                                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                                return Text('Image not available!');
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                  12.0,
                                                                                  0.0,
                                                                                  0.0,
                                                                                  0.0),
                                                                              child:
                                                                              Column(
                                                                                mainAxisSize:
                                                                                MainAxisSize.max,
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      actualesItem.nombreSorteo,
                                                                                      '[nombre_sorteo]',
                                                                                    ),
                                                                                    maxLines: 2,
                                                                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      fontSize: 20.0,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                                                                                    ),
                                                                                  ),
                                                                                  // Padding(
                                                                                  //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                  //   child: Text(
                                                                                  //     valueOrDefault<String>(
                                                                                  //       'Tu emoji es: ${valueOrDefault<String>(
                                                                                  //         containerSelectedTicketsRecordList.where((e) => e.parentReference == actualesItem.reference).toList().first.imagen,
                                                                                  //         'null',
                                                                                  //       )}',
                                                                                  //       'Esperando emoji...',
                                                                                  //     ),
                                                                                  //     style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                  //           fontFamily: 'Montserrat',
                                                                                  //           fontSize: 14.0,
                                                                                  //           useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                  //         ),
                                                                                  //   ),
                                                                                  // ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        'Valor: ${valueOrDefault<String>(
                                                                                          formatNumber(
                                                                                            actualesItem.valorSorteo,
                                                                                            formatType: FormatType.decimal,
                                                                                            decimalType: DecimalType.automatic,
                                                                                            currency: '',
                                                                                          ),
                                                                                          '€0.00',
                                                                                        )}',
                                                                                        '€0.00',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        fontFamily: 'Montserrat',
                                                                                        fontSize: 18.0,
                                                                                        color: FlutterFlowTheme.of(context).accent3,
                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
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
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 12.0, 0.0, 12.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final pasados =
                                                          historicoSorteosRecordList
                                                              .where((e) =>
                                                              valueOrDefault<
                                                                  bool>(
                                                                e.jugoSorteo
                                                                    .contains(
                                                                    currentUserReference),
                                                                true,
                                                              ))
                                                              .toList()
                                                              .map((e) => e)
                                                              .toList();
                                                          if (pasados.isEmpty) {
                                                            return Center(
                                                              child: Container(
                                                                width: 300.0,
                                                                height: 250.0,
                                                                child: NoDataWidget(),
                                                              ),
                                                            );
                                                          }
                                                          return ListView.builder(
                                                            padding: EdgeInsets.zero,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                            Axis.vertical,
                                                            itemCount: pasados.length,
                                                            itemBuilder: (context,
                                                                pasadosIndex) {
                                                              final pasadosItem =
                                                              pasados[
                                                              pasadosIndex];
                                                              return Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    8.0),
                                                                child: Container(
                                                                  width:
                                                                  double.infinity,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: FlutterFlowTheme
                                                                        .of(context)
                                                                        .secondaryBackground,
                                                                    // boxShadow: [
                                                                    //   BoxShadow(
                                                                    //     blurRadius:
                                                                    //     4.0,
                                                                    //     color: Color(
                                                                    //         0x520E151B),
                                                                    //     offset:
                                                                    //     Offset(
                                                                    //         0.0,
                                                                    //         2.0),
                                                                    //   )
                                                                    // ],
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        8.0),
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
                                                                  child: Padding(
                                                                    padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        8.0,
                                                                        8.0,
                                                                        8.0,
                                                                        8.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                          BorderRadius.circular(
                                                                              6.0),
                                                                          child: Image
                                                                              .network(
                                                                            pasadosItem
                                                                                .imagenRef,
                                                                            width:
                                                                            80.0,
                                                                            height:
                                                                            80.0,
                                                                            fit: BoxFit
                                                                                .cover,
                                                                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                              return Text('Image');
                                                                            },
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                12.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                            Column(
                                                                              mainAxisSize:
                                                                              MainAxisSize.max,
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  pasadosItem.nombreSorteo,
                                                                                  maxLines:
                                                                                  2,
                                                                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 20.0,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                      0.0,
                                                                                      5.0,
                                                                                      0.0,
                                                                                      0.0),
                                                                                  child:
                                                                                  Text(
                                                                                    'Tu emoji fue: ${containerSelectedTicketsRecordList.where((e) => e.parentReference == pasadosItem.reference).toList().first.imagen}',
                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      color: FlutterFlowTheme.of(context).accent3,
                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                      0.0,
                                                                                      5.0,
                                                                                      0.0,
                                                                                      0.0),
                                                                                  child:
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Valor: ${formatNumber(
                                                                                            pasadosItem.valorSorteo,
                                                                                            formatType: FormatType.decimal,
                                                                                            decimalType: DecimalType.automatic,
                                                                                            currency: '€',
                                                                                          )}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            fontFamily: 'Montserrat',
                                                                                            fontSize: 18.0,
                                                                                            color: FlutterFlowTheme.of(context).accent3,
                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      if (currentUserReference == pasadosItem.ganador)
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                                              child: Text(
                                                                                                'GANADOR',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  fontSize: 18.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            FaIcon(
                                                                                              FontAwesomeIcons.trophy,
                                                                                              color: Color.fromARGB(
                                                                                                  250,
                                                                                                  255,
                                                                                                  204,
                                                                                                  0),
                                                                                              size: 20.0,
                                                                                            ),
                                                                                          ],
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
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (!valueOrDefault<bool>(
                              currentUserDocument?.isAdmin, false))
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: wrapWithModel(
                                model: _model.navBarFlotingModel,
                                updateCallback: () => setState(() {}),
                                child: NavBarFlotingWidget(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if(dorpDownValue == "Cuenta regresive")
                    Expanded(
                      child: SafeArea(
                        top: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SafeArea(
                                top: true,
                                child: FutureBuilder(
                                  future: getSorteo2Ref(),
                                  builder: (context,snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryBackground,),);
                                    }
                                    if(snapshot.data == null){
                                      return SizedBox();
                                    }
                                    if(snapshot.connectionState == ConnectionState.done){
                                      List drawlist = snapshot.data!;
                                      return ListView(
                                        physics: ClampingScrollPhysics(),
                                        children: drawlist.map((e){
                                          return FutureBuilder(
                                              future: getDraw(e),
                                              builder: (context, drawSnapshot){
                                                if(drawSnapshot.connectionState == ConnectionState.waiting){
                                                  return Center(child: Text("Loading"),);
                                                }
                                                if(drawSnapshot.connectionState == ConnectionState.done) {
                                                  Map<String,dynamic> drawData = drawSnapshot.data!;
                                                  DocumentReference docRef = drawData['ref'];
                                                  if(drawData['winner'] != null){
                                                    return FutureBuilder(future: getWinnerData(drawData['winner']),
                                                        builder: (context, winnerSnapshot){
                                                          if(winnerSnapshot.data == null){
                                                            return SizedBox();
                                                          }
                                                          if(winnerSnapshot.connectionState == ConnectionState.done){
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                              margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                                                                    height: 110,
                                                                    width: 100,
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        child: Image.network(drawData['image'],fit: BoxFit.cover,)),
                                                                  ),
                                                                  SizedBox(width: 3,),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: [
                                                                        Text(drawData['name']??"",style: FlutterFlowTheme.of(context).titleMedium,),
                                                                        SizedBox(height: 5,),
                                                                        Text("Volver: \$${drawData['value']}"),
                                                                        SizedBox(height: 5,),
                                                                        Text(
                                                                          valueOrDefault<String>(
                                                                            'Ganador: ${winnerSnapshot.data!['display_name']}',
                                                                            'Ganador: [user]',
                                                                          ),
                                                                          textAlign: TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            color: FlutterFlowTheme.of(context).accent3,
                                                                            fontSize: 14.0,
                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                          ),
                                                                        ),
                                                                        StreamBuilder(
                                                                            stream: docRef.collection("participant").where('userRef', isEqualTo: drawData['winner']).snapshots(),
                                                                            builder: (context, p){
                                                                              if(p.connectionState == ConnectionState.active){
                                                                                if(p.data!.docs.isEmpty){
                                                                                  return SizedBox();
                                                                                }
                                                                                return Row(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          0.0,
                                                                                          5.0,
                                                                                          0.0,
                                                                                          5.0),
                                                                                      child:
                                                                                      Text(
                                                                                        valueOrDefault<String>(
                                                                                          'emoji ganador: ',
                                                                                          'Ganador: [emoji]',
                                                                                        ),
                                                                                        textAlign: TextAlign.start,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Montserrat',
                                                                                          color: FlutterFlowTheme.of(context).accent3,
                                                                                          fontSize: 14.0,
                                                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Text(p.data!.docs[0].data()['tickets'][0].toString(),style: TextStyle(
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Color.fromARGB(
                                                                                            255,
                                                                                            245,
                                                                                            161,
                                                                                            3)
                                                                                    ),),
                                                                                  ],
                                                                                );
                                                                              }
                                                                              return SizedBox();
                                                                            }
                                                                        ),
                                                                        // Row(
                                                                        //   children: [
                                                                        //     InkWell(
                                                                        //       onTap: (){
                                                                        //         Navigator.push(context, MaterialPageRoute(builder: (context)=> EditDraw2(drawRef: drawData['ref'])));
                                                                        //       },
                                                                        //       child: Icon(Icons.edit,color: FlutterFlowTheme.of(context).accent3,),
                                                                        //     ),
                                                                        //     SizedBox(width: 10,),
                                                                        //     InkWell(
                                                                        //       onTap: (){
                                                                        //         Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                                                        //       },
                                                                        //       child: Icon(Icons.person_add_alt_1_rounded,color: FlutterFlowTheme.of(context).accent3,),
                                                                        //     ),
                                                                        //   ],
                                                                        // )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // Text(drawData['status']?"Open":"Close"),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                          return SizedBox();
                                                        }
                                                    );
                                                  }
                                                  else{
                                                    return Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                      margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                                                        children: [
                                                          drawData['image'] == null?
                                                          SizedBox(
                                                            height: 50,
                                                            width: 70,): SizedBox(
                                                            height: 50,
                                                            width: 70,
                                                            child: Image.network(drawData['image'],fit: BoxFit.cover,),
                                                          ),
                                                          SizedBox(width: 20,),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(drawData['name']??"",style: FlutterFlowTheme.of(context).labelLarge,),
                                                                SizedBox(height: 5,),
                                                                Text("Volver: \$${drawData['value']}"),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(drawData['status']??false?"Open":"Closed"),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                  return Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                    child: ListTile(
                                                      tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                      leading: Image.network(drawData['image']),
                                                      title: Text(drawData['name']),
                                                    ),
                                                  );
                                                }
                                                return Center(child: Text("Not found"),);

                                              }
                                          );
                                        }).toList(),
                                      );
                                    }
                                    return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryBackground,),);
                                  },
                                ),
                              ),
                            ),
                            if (!valueOrDefault<bool>(
                                currentUserDocument?.isAdmin, false))
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.navBarFlotingModel,
                                  updateCallback: () => setState(() {}),
                                  child: NavBarFlotingWidget(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  if(dorpDownValue == "Elige tu numero de la suerte")
                    Expanded(
                      child: SafeArea(
                        top: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SafeArea(
                                top: true,
                                child: FutureBuilder(
                                  future: getSorteo3Ref(),
                                  builder: (context,snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryBackground,),);
                                    }
                                    if(snapshot.data == null){
                                      return SizedBox();
                                    }
                                    if(snapshot.connectionState == ConnectionState.done){
                                      List drawlist = snapshot.data!;
                                      return ListView(
                                        physics: ClampingScrollPhysics(),
                                        children: drawlist.map((e){
                                          return FutureBuilder(
                                              future: getDraw(e),
                                              builder: (context, drawSnapshot){
                                                if(drawSnapshot.connectionState == ConnectionState.waiting){
                                                  return Center(child: Text("Loading"),);
                                                }
                                                if(drawSnapshot.connectionState == ConnectionState.done) {
                                                  Map<String,dynamic> drawData = drawSnapshot.data!;
                                                  DocumentReference docRef = drawData['ref'];
                                                  if(drawData['winner'] != null){
                                                    return FutureBuilder(future: getWinnerData(drawData['winner']),
                                                        builder: (context, winnerSnapshot){
                                                          if(winnerSnapshot.data == null){
                                                            return SizedBox();
                                                          }
                                                          if(winnerSnapshot.connectionState == ConnectionState.done){
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                              margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                                                                    height: 110,
                                                                    width: 100,
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        child: Image.network(drawData['image'],fit: BoxFit.cover,)),
                                                                  ),
                                                                  SizedBox(width: 3,),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: [
                                                                        Text(drawData['name']??"",style: FlutterFlowTheme.of(context).titleMedium,),
                                                                        SizedBox(height: 5,),
                                                                        Text("Volver: \$${drawData['value']}"),
                                                                        SizedBox(height: 5,),
                                                                        Text(
                                                                          valueOrDefault<String>(
                                                                            'Ganador: ${winnerSnapshot.data!['display_name']}',
                                                                            'Ganador: [user]',
                                                                          ),
                                                                          textAlign: TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            color: FlutterFlowTheme.of(context).accent3,
                                                                            fontSize: 14.0,
                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                          ),
                                                                        ),
                                                                        StreamBuilder(
                                                                            stream: docRef.collection("participant").where('userRef', isEqualTo: drawData['winner']).snapshots(),
                                                                            builder: (context, p){
                                                                              if(p.connectionState == ConnectionState.active){
                                                                                if(p.data!.docs.isEmpty){
                                                                                  return SizedBox();
                                                                                }
                                                                                return Row(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          0.0,
                                                                                          5.0,
                                                                                          0.0,
                                                                                          5.0),
                                                                                      child:
                                                                                      Text(
                                                                                        valueOrDefault<String>(
                                                                                          'emoji ganador: ',
                                                                                          'Ganador: [emoji]',
                                                                                        ),
                                                                                        textAlign: TextAlign.start,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Montserrat',
                                                                                          color: FlutterFlowTheme.of(context).accent3,
                                                                                          fontSize: 14.0,
                                                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Text(p.data!.docs[0].data()['tickets'][0].toString(),style: TextStyle(
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Color.fromARGB(
                                                                                            255,
                                                                                            245,
                                                                                            161,
                                                                                            3)
                                                                                    ),),
                                                                                  ],
                                                                                );
                                                                              }
                                                                              return SizedBox();
                                                                            }
                                                                        ),
                                                                        // Row(
                                                                        //   children: [
                                                                        //     InkWell(
                                                                        //       onTap: (){
                                                                        //         Navigator.push(context, MaterialPageRoute(builder: (context)=> EditDraw2(drawRef: drawData['ref'])));
                                                                        //       },
                                                                        //       child: Icon(Icons.edit,color: FlutterFlowTheme.of(context).accent3,),
                                                                        //     ),
                                                                        //     SizedBox(width: 10,),
                                                                        //     InkWell(
                                                                        //       onTap: (){
                                                                        //         Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                                                        //       },
                                                                        //       child: Icon(Icons.person_add_alt_1_rounded,color: FlutterFlowTheme.of(context).accent3,),
                                                                        //     ),
                                                                        //   ],
                                                                        // )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // Text(drawData['status']?"Open":"Close"),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                          return SizedBox();
                                                        }
                                                    );
                                                  }
                                                  else{
                                                    return Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                      margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                                                        children: [
                                                          SizedBox(
                                                            height: 50,
                                                            width: 70,
                                                            child: drawData['image'] == null? SizedBox():Image.network(drawData['image'],fit: BoxFit.cover,),
                                                          ),
                                                          SizedBox(width: 20,),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(drawData['name']??"",style: FlutterFlowTheme.of(context).labelLarge,),
                                                                SizedBox(height: 5,),
                                                                Text("Volver: \$${drawData['value']}"),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(drawData['status']??false?"Open":"Closed"),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                  return Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                    child: ListTile(
                                                      tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                      leading: Image.network(drawData['image']),
                                                      title: Text(drawData['name']),
                                                    ),
                                                  );
                                                }
                                                return Center(child: Text("Not found"),);

                                              }
                                          );
                                        }).toList(),
                                      );
                                    }
                                    return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryBackground,),);
                                  },
                                ),
                              ),
                            ),
                            if (!valueOrDefault<bool>(
                                currentUserDocument?.isAdmin, false))
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.navBarFlotingModel,
                                  updateCallback: () => setState(() {}),
                                  child: NavBarFlotingWidget(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  if(dorpDownValue == "Sorteo privado")
                    Expanded(
                      child: SafeArea(
                        top: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SafeArea(
                                top: true,
                                child: FutureBuilder(
                                  future: getSorteo4Ref(),
                                  builder: (context,snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryBackground,),);
                                    }
                                    if(snapshot.data == null){
                                      return SizedBox();
                                    }
                                    if(snapshot.connectionState == ConnectionState.done){
                                      List drawlist = snapshot.data!;
                                      return ListView(
                                        physics: ClampingScrollPhysics(),
                                        children: drawlist.map((e){
                                          return FutureBuilder(
                                              future: getDraw(e),
                                              builder: (context, drawSnapshot){
                                                if(drawSnapshot.connectionState == ConnectionState.waiting){
                                                  return Center(child: Text("Loading"),);
                                                }
                                                if(drawSnapshot.connectionState == ConnectionState.done) {
                                                  Map<String,dynamic> drawData = drawSnapshot.data!;
                                                  DocumentReference docRef = drawData['ref'];
                                                  if(drawData['winner'] != null){
                                                    return FutureBuilder(future: getWinnerData(drawData['winner']),
                                                        builder: (context, winnerSnapshot){
                                                          if(winnerSnapshot.data == null){
                                                            return SizedBox();
                                                          }
                                                          if(winnerSnapshot.connectionState == ConnectionState.done){
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                              margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                                                                    height: 110,
                                                                    width: 100,
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        child: Image.network(drawData['image'],fit: BoxFit.cover,)),
                                                                  ),
                                                                  SizedBox(width: 3,),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: [
                                                                        Text(drawData['name']??"",style: FlutterFlowTheme.of(context).titleMedium,),
                                                                        SizedBox(height: 5,),
                                                                        Text("Volver: \$${drawData['value']}"),
                                                                        SizedBox(height: 5,),
                                                                        Text(
                                                                          valueOrDefault<String>(
                                                                            'Ganador: ${winnerSnapshot.data!['display_name']}',
                                                                            'Ganador: [user]',
                                                                          ),
                                                                          textAlign: TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Montserrat',
                                                                            color: FlutterFlowTheme.of(context).accent3,
                                                                            fontSize: 14.0,
                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                          ),
                                                                        ),
                                                                        StreamBuilder(
                                                                            stream: docRef.collection("participant").where('userRef', isEqualTo: drawData['winner']).snapshots(),
                                                                            builder: (context, p){
                                                                              if(p.connectionState == ConnectionState.active){
                                                                                if(p.data!.docs.isEmpty){
                                                                                  return SizedBox();
                                                                                }
                                                                                return Row(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          0.0,
                                                                                          5.0,
                                                                                          0.0,
                                                                                          5.0),
                                                                                      child:
                                                                                      Text(
                                                                                        valueOrDefault<String>(
                                                                                          'emoji ganador: ',
                                                                                          'Ganador: [emoji]',
                                                                                        ),
                                                                                        textAlign: TextAlign.start,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Montserrat',
                                                                                          color: FlutterFlowTheme.of(context).accent3,
                                                                                          fontSize: 14.0,
                                                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Text(p.data!.docs[0].data()['tickets'][0].toString(),style: TextStyle(
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Color.fromARGB(
                                                                                            255,
                                                                                            245,
                                                                                            161,
                                                                                            3)
                                                                                    ),),
                                                                                  ],
                                                                                );
                                                                              }
                                                                              return SizedBox();
                                                                            }
                                                                        ),
                                                                        // Row(
                                                                        //   children: [
                                                                        //     InkWell(
                                                                        //       onTap: (){
                                                                        //         Navigator.push(context, MaterialPageRoute(builder: (context)=> EditDraw2(drawRef: drawData['ref'])));
                                                                        //       },
                                                                        //       child: Icon(Icons.edit,color: FlutterFlowTheme.of(context).accent3,),
                                                                        //     ),
                                                                        //     SizedBox(width: 10,),
                                                                        //     InkWell(
                                                                        //       onTap: (){
                                                                        //         Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                                                        //       },
                                                                        //       child: Icon(Icons.person_add_alt_1_rounded,color: FlutterFlowTheme.of(context).accent3,),
                                                                        //     ),
                                                                        //   ],
                                                                        // )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // Text(drawData['status']?"Open":"Close"),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                          return SizedBox();
                                                        }
                                                    );
                                                  }
                                                  else{
                                                    return Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                      margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                                                        children: [
                                                          SizedBox(
                                                            height: 50,
                                                            width: 70,
                                                            child: drawData['image'] == null? SizedBox():Image.network(drawData['image'],fit: BoxFit.cover,),
                                                          ),
                                                          SizedBox(width: 20,),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(drawData['name']??"",style: FlutterFlowTheme.of(context).labelLarge,),
                                                                SizedBox(height: 5,),
                                                                // Text("Volver: \$${drawData['value']}"),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(drawData['status']??false?"Open":"Closed"),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                  return Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                    child: ListTile(
                                                      tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                      leading: Image.network(drawData['image']),
                                                      title: Text(drawData['name']),
                                                    ),
                                                  );
                                                }
                                                return Center(child: Text("Not found"),);
                                              }
                                          );
                                        }).toList(),
                                      );
                                    }
                                    return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryBackground,),);
                                  },
                                ),
                              ),
                            ),
                            if (!valueOrDefault<bool>(
                                currentUserDocument?.isAdmin, false))
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.navBarFlotingModel,
                                  updateCallback: () => setState(() {}),
                                  child: NavBarFlotingWidget(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List> getSorteo2Ref()async{
    List drawRefList = [];
    await currentUserReference!.get().then((value){
      Map<String,dynamic> data = value.data() as Map<String,dynamic>;
      print("!22");
      final r = data['Sorteo2'];
      print(r);
      // print(data['Sorteo2'][0]);
      drawRefList = data['Sorteo2'];
    });
    print("lskdf..");
    print(drawRefList);
    return drawRefList;
  }

  Future<List> getSorteo3Ref()async{
    List drawRefList = [];
    await currentUserReference!.get().then((value){
      Map<String,dynamic> data = value.data() as Map<String,dynamic>;
      final r = data['Sorteo3'];
      print(r);
      drawRefList = data['Sorteo3'];
    });
    print(drawRefList);
    return drawRefList;
  }
  Future<List> getSorteo4Ref()async{
    List drawRefList = [];
    await currentUserReference!.get().then((value){
      Map<String,dynamic> data = value.data() as Map<String,dynamic>;
      final r = data['Sorteo4'];
      print(r);
      drawRefList = data['Sorteo4'];
    });
    print(drawRefList);
    return drawRefList;
  }

  Future<Map<String,dynamic>> getDraw(DocumentReference reference)async{
    Map<String,dynamic> drawData = {};
    await reference.get().then((value){
      if(value.data()!= null){
        drawData = value.data() as Map<String,dynamic>;
      }
    });
    return drawData;
  }


  Future<Map<String,dynamic>> getWinnerData(DocumentReference docref)async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String,dynamic> userData = {};
    await firestore.collection("users").doc(docref.id).get().then((value){
      if(value.data() != null){
        userData = value.data()!;
      }
    });
    return userData;
  }
}
