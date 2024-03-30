import 'package:fluttertoast/fluttertoast.dart';
import 'package:sorteoaganar/admin/Draw3ParticipantList/Draw3ParticipantList.dart';
import 'package:sorteoaganar/admin/EditDraw2/EditDraw2.dart';
import 'package:sorteoaganar/admin/EditDraw4/EditDraw4.dart';
import 'package:sorteoaganar/admin/add_user_sorteo2/AddUserSorteo2.dart';

import '../Draw4ParticipantList/Draw4ParticipantList.dart';
import '../add_user_sorteo3/AddUserSorteo3.dart';
import '../add_user_sorteo4/AddUserSorteo4.dart';
import '/admin/add_user_sorteo/add_user_sorteo_widget.dart';
import '/admin/edit_sorteo/edit_sorteo_widget.dart';
import '/admin/sorteo_users_list/sorteo_users_list_widget.dart';
import '/backend/backend.dart';
import '/components/custom_alert/custom_alert_widget.dart';
import '/components/no_data/no_data_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'admin_sorteos_model.dart';
export 'admin_sorteos_model.dart';

class AdminSorteosWidget extends StatefulWidget {
  const AdminSorteosWidget({Key? key}) : super(key: key);

  @override
  _AdminSorteosWidgetState createState() => _AdminSorteosWidgetState();
}

class _AdminSorteosWidgetState extends State<AdminSorteosWidget>
    with TickerProviderStateMixin {
  late AdminSorteosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminSorteosModel());

    _model.searchBarController ??= TextEditingController();
    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }


  var items = [
    'Emoji ganador',
    'Cuenta regresive',
    'Elige tu numero de la suerte',
    'Sorteo privado'
  ];

  String dorpDownValue = "Emoji ganador";
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<SorteosRecord>>(
      stream: querySorteosRecord(
        queryBuilder: (sorteosRecord) =>
            sorteosRecord.orderBy('fecha_creacion', descending: true),
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
        List<SorteosRecord> adminSorteosSorteosRecordList = snapshot.data!;
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
              title: Text(
                'Sorteos',
                style: FlutterFlowTheme.of(context).titleLarge,
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 600.0,
                ),
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
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
                                      adminSorteosSorteosRecordList
                                          .map(
                                            (record) => TextSearchItem(
                                                record, [record.nombreSorteo!]),
                                          )
                                          .toList(),
                                    )
                                        .search(_model.searchBarController.text)
                                        .map((r) => r.object)
                                        .toList();
                                    ;
                                  });
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Buscar Sorteos',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .titleSmall,
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .titleSmall,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .lineColor,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .plumpPurple,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
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
                                        .secondaryBackground,
                                    size: 16.0,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                validator: _model.searchBarControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment(0.0, 0),
                              child: TabBar(
                                labelColor:
                                    FlutterFlowTheme.of(context).secondary,
                                unselectedLabelColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily),
                                    ),
                                unselectedLabelStyle: TextStyle(
                                  color: FlutterFlowTheme.of(context).secondary
                                ),
                                indicatorColor:
                                    FlutterFlowTheme.of(context).plumpPurple,
                                tabs: [
                                  Tab(
                                    text: 'En Curso',
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
                                      if (_model.searchBarController.text ==
                                              null ||
                                          _model.searchBarController.text == '')
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 5.0),
                                            child: Builder(
                                              builder: (context) {
                                                final enCurso =
                                                    adminSorteosSorteosRecordList
                                                        .where((e) =>
                                                            e.estadoSorteo)
                                                        .toList();
                                                if (enCurso.isEmpty) {
                                                  return Center(
                                                    child: Container(
                                                      width: 300.0,
                                                      child: NoDataWidget(),
                                                    ),
                                                  );
                                                }
                                                return SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                        enCurso.length,
                                                        (enCursoIndex) {
                                                      final enCursoItem =
                                                          enCurso[enCursoIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    8.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
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
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      enCursoItem
                                                                          .imagenRef,
                                                                      'https://app.vinglet.com/default-image.png',
                                                                    ),
                                                                    width: 90.0,
                                                                    height:
                                                                        90.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                child: Text(
                                                                                  enCursoItem.nombreSorteo,
                                                                                  textAlign: TextAlign.start,
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                        fontFamily: 'Montserrat',
                                                                                        fontSize: 20.0,
                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              5.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            'Valor: ${formatNumber(
                                                                              enCursoItem.valorSorteo,
                                                                              formatType: FormatType.decimal,
                                                                              decimalType: DecimalType.automatic,
                                                                              currency: '€',
                                                                            )}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              10.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => EditSorteoWidget(
                                                                                          editSorteos: enCursoItem.reference,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit_outlined,
                                                                                    color: FlutterFlowTheme.of(context).accent3,
                                                                                    size: 24.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    if (enCursoItem.selectedTickets.length == enCursoItem.limiteParticipantes) {
                                                                                      await showModalBottomSheet(
                                                                                        isScrollControlled: true,
                                                                                        backgroundColor: Colors.transparent,
                                                                                        isDismissible: false,
                                                                                        enableDrag: false,
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return GestureDetector(
                                                                                            onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                                            child: Padding(
                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                              child: CustomAlertWidget(
                                                                                                title: 'Añadir Usuarios',
                                                                                                body: 'El cupo de usuarios para este sorteo esta completo!!!',
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      ).then((value) => setState(() {}));
                                                                                      Navigator.pop(context);
                                                                                    } else {
                                                                                      Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                          builder: (context) => AddUserSorteoWidget(
                                                                                            sorteoAdd: enCursoItem.reference,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.person_add_outlined,
                                                                                    color: FlutterFlowTheme.of(context).accent3,
                                                                                    size: 24.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => SorteoUsersListWidget(
                                                                                          usersInLottery: enCursoItem.reference,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: FaIcon(
                                                                                    FontAwesomeIcons.listOl,
                                                                                    color: FlutterFlowTheme.of(context).accent3,
                                                                                    size: 24.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    if (enCursoItem.selectedTickets.length > 0) {
                                                                                      await showModalBottomSheet(
                                                                                        isScrollControlled: true,
                                                                                        backgroundColor: Colors.transparent,
                                                                                        isDismissible: false,
                                                                                        enableDrag: false,
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return GestureDetector(
                                                                                            onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                                            child: Padding(
                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                              child: CustomAlertWidget(
                                                                                                title: 'Eliminar Sorteo',
                                                                                                body: 'No se puede eliminar sorteos con participantes!!!',
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      ).then((value) => setState(() {}));
                                                                                    } else {
                                                                                      var confirmDialogResponse = await showDialog<bool>(
                                                                                            context: context,
                                                                                            builder: (alertDialogContext) {
                                                                                              return AlertDialog(
                                                                                                title: Text('Eliminar Sorteo'),
                                                                                                content: Text('Estas seguro de Eliminar el Sorteo ${enCursoItem.nombreSorteo}?'),
                                                                                                actions: [
                                                                                                  TextButton(
                                                                                                    onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                    child: Text('Cancelar'),
                                                                                                  ),
                                                                                                  TextButton(
                                                                                                    onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                                    child: Text('Ok'),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            },
                                                                                          ) ??
                                                                                          false;
                                                                                      if (confirmDialogResponse) {
                                                                                        await enCursoItem.reference.delete();
                                                                                        await showModalBottomSheet(
                                                                                          isScrollControlled: true,
                                                                                          backgroundColor: Colors.transparent,
                                                                                          isDismissible: false,
                                                                                          enableDrag: false,
                                                                                          context: context,
                                                                                          builder: (context) {
                                                                                            return GestureDetector(
                                                                                              onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                                              child: Padding(
                                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                                child: CustomAlertWidget(
                                                                                                  title: 'Eliminar Sorteo',
                                                                                                  body: 'Sorteo Eliminado!!!',
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ).then((value) => setState(() {}));
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.delete_forever,
                                                                                    color: FlutterFlowTheme.of(context).accent3,
                                                                                    size: 24.0,
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
                                                      );
                                                    }),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      if (_model.searchBarController.text !=
                                              null &&
                                          _model.searchBarController.text != '')
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 5.0),
                                            child: Builder(
                                              builder: (context) {
                                                final enCursoSearch = _model
                                                    .simpleSearchResults
                                                    .where(
                                                        (e) => e.estadoSorteo)
                                                    .toList()
                                                    .map((e) => e)
                                                    .toList();
                                                if (enCursoSearch.isEmpty) {
                                                  return Center(
                                                    child: Container(
                                                      width: 300.0,
                                                      child: NoDataWidget(),
                                                    ),
                                                  );
                                                }
                                                return SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: List.generate(
                                                        enCursoSearch.length,
                                                        (enCursoSearchIndex) {
                                                      final enCursoSearchItem =
                                                          enCursoSearch[
                                                              enCursoSearchIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    8.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8.0,
                                                                        8.0,
                                                                        12.0,
                                                                        8.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      enCursoSearchItem
                                                                          .imagenRef,
                                                                      'https://app.vinglet.com/default-image.png',
                                                                    ),
                                                                    width: 90.0,
                                                                    height:
                                                                        90.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              10.0,
                                                                              0.0,
                                                                              5.0),
                                                                          child:
                                                                              Text(
                                                                            enCursoSearchItem.nombreSorteo,
                                                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  fontSize: 22.0,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
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
                                                                              Text(
                                                                            'Valor: ${formatNumber(
                                                                              enCursoSearchItem.valorSorteo,
                                                                              formatType: FormatType.decimal,
                                                                              decimalType: DecimalType.automatic,
                                                                              currency: '€',
                                                                            )}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              10.0,
                                                                              8.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => EditSorteoWidget(
                                                                                          editSorteos: enCursoSearchItem.reference,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit_outlined,
                                                                                    color: FlutterFlowTheme.of(context).grayIcon,
                                                                                    size: 24.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => AddUserSorteoWidget(
                                                                                          sorteoAdd: enCursoSearchItem.reference,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.person_add_outlined,
                                                                                    color: FlutterFlowTheme.of(context).grayIcon,
                                                                                    size: 24.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => SorteoUsersListWidget(
                                                                                          usersInLottery: enCursoSearchItem.reference,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: FaIcon(
                                                                                    FontAwesomeIcons.listOl,
                                                                                    color: FlutterFlowTheme.of(context).grayIcon,
                                                                                    size: 24.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    if (enCursoSearchItem.selectedTickets.length > 0) {
                                                                                      await showModalBottomSheet(
                                                                                        isScrollControlled: true,
                                                                                        backgroundColor: Colors.transparent,
                                                                                        isDismissible: false,
                                                                                        enableDrag: false,
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return GestureDetector(
                                                                                            onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                                            child: Padding(
                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                              child: CustomAlertWidget(
                                                                                                title: 'Eliminar Sorteo',
                                                                                                body: 'No se puede eliminar un sorteo el cual tiene particpantes!!!',
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      ).then((value) => setState(() {}));
                                                                                    } else {
                                                                                      await enCursoSearchItem.reference.delete();
                                                                                      await showModalBottomSheet(
                                                                                        isScrollControlled: true,
                                                                                        backgroundColor: Colors.transparent,
                                                                                        isDismissible: false,
                                                                                        enableDrag: false,
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return GestureDetector(
                                                                                            onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                                            child: Padding(
                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                              child: CustomAlertWidget(
                                                                                                title: 'Eliminar Sorteo',
                                                                                                body: 'Sorteo Eliminado!!!',
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      ).then((value) => setState(() {}));
                                                                                    }
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.delete_forever_rounded,
                                                                                    color: FlutterFlowTheme.of(context).grayIcon,
                                                                                    size: 24.0,
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
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (_model.searchBarController.text == null || _model.searchBarController.text == '')
                                        Expanded(
                                          child: Builder(
                                            builder: (context) {
                                              final pasados =
                                                  adminSorteosSorteosRecordList
                                                      .where((e) =>
                                                          !e.estadoSorteo)
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
                                              return SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: List.generate(
                                                      pasados.length,
                                                      (pasadosIndex) {
                                                    final pasadosItem =
                                                        pasados[pasadosIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  8.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: StreamBuilder<List<UsersRecord>>(
                                                        stream:
                                                            queryUsersRecord(
                                                          queryBuilder: (usersRecord) =>
                                                              usersRecord.where(
                                                                  'uid',
                                                                  isEqualTo: valueOrDefault<
                                                                              String>(
                                                                            pasadosItem.ganador?.id,
                                                                            'null',
                                                                          ) !=
                                                                          ''
                                                                      ? valueOrDefault<
                                                                          String>(
                                                                          pasadosItem
                                                                              .ganador
                                                                              ?.id,
                                                                          'null',
                                                                        )
                                                                      : null),
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context, snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 26.0,
                                                                height: 26.0,
                                                                child:
                                                                    SpinKitDoubleBounce(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  size: 26.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<UsersRecord>
                                                              containerUsersRecordList =
                                                              snapshot.data!;
                                                          UsersRecord? containerUsersRecord =
                                                              containerUsersRecordList
                                                                      .isNotEmpty
                                                                  ? containerUsersRecordList
                                                                      .first
                                                                  : null;
                                                          return Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
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
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        pasadosItem
                                                                            .imagenRef,
                                                                        'https://app.vinglet.com/default-image.png',
                                                                      ),
                                                                      width:
                                                                          70.0,
                                                                      height:
                                                                          70.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                pasadosItem.nombreSorteo,
                                                                                'NoData',
                                                                              ),
                                                                              textAlign: TextAlign.start,
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 22.0,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                'Ganador: ${valueOrDefault<String>(
                                                                                  containerUsersRecord?.displayName,
                                                                                  'Actualizando dato...',
                                                                                )}',
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
                                                                          ),
                                                                          // Get winner emoji
                                                                          StreamBuilder(
                                                                              stream: pasadosItem.reference.collection("selectedTickets").where('usuario', isEqualTo: pasadosItem.ganador).snapshots(),
                                                                              builder: (context, p){
                                                                                if(p.connectionState == ConnectionState.active){
                                                                                  if(p.data!.docs.isEmpty){
                                                                                    return SizedBox();
                                                                                  }
                                                                                  return Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                        0.0,
                                                                                        0.0,
                                                                                        0.0,
                                                                                        0.0),
                                                                                    child:
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        'emoji ganador: ${valueOrDefault<String>(
                                                                                          p.data!.docs[0].data()['imagen']
                                                                                          ,
                                                                                          'Actualizando dato...',
                                                                                        )}',
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
                                                                                  );
                                                                                }
                                                                                return SizedBox();
                                                                              }
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Text(
                                                                              'Valor: ${valueOrDefault<String>(
                                                                                formatNumber(
                                                                                  pasadosItem.valorSorteo,
                                                                                  formatType: FormatType.decimal,
                                                                                  decimalType: DecimalType.automatic,
                                                                                  currency: '€',
                                                                                ),
                                                                                '€',
                                                                              )}',
                                                                              textAlign: TextAlign.end,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 16.0,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Text(
                                                                              'identificación: ${pasadosItem.uid}',
                                                                              textAlign: TextAlign.start,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 14.0,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                            children: [
                                                                              Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(10)
                                                                                ),
                                                                                child: Text("${pasadosItem.fechaCreacion!.hour}:${pasadosItem.fechaCreacion!.minute} ${pasadosItem.fechaCreacion!.year}-${pasadosItem.fechaCreacion!.month}-${pasadosItem.fechaCreacion!.day}"),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => SorteoUsersListWidget(
                                                                                  usersInLottery: pasadosItem.reference,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.listOl,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).accent3,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      if (_model.searchBarController.text !=
                                              null &&
                                          _model.searchBarController.text != '')
                                        Expanded(
                                          child: Builder(
                                            builder: (context) {
                                              final pasadosSearch = _model
                                                  .simpleSearchResults
                                                  .where((e) => !e.estadoSorteo)
                                                  .toList()
                                                  .map((e) => e)
                                                  .toList();
                                              if (pasadosSearch.isEmpty) {
                                                return Center(
                                                  child: Container(
                                                    width: 300.0,
                                                    height: 250.0,
                                                    child: NoDataWidget(),
                                                  ),
                                                );
                                              }
                                              return SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: List.generate(
                                                      pasadosSearch.length,
                                                      (pasadosSearchIndex) {
                                                    final pasadosSearchItem =
                                                        pasadosSearch[
                                                            pasadosSearchIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  8.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: StreamBuilder<
                                                          List<UsersRecord>>(
                                                        stream:
                                                            queryUsersRecord(
                                                          queryBuilder: (usersRecord) =>
                                                              usersRecord.where(
                                                                  'uid',
                                                                  isEqualTo:
                                                                      valueOrDefault<
                                                                          String>(
                                                                    pasadosSearchItem
                                                                        .ganador
                                                                        ?.id,
                                                                    'null',
                                                                  )),
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 26.0,
                                                                height: 26.0,
                                                                child:
                                                                    SpinKitDoubleBounce(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  size: 26.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<UsersRecord>
                                                              containerUsersRecordList =
                                                              snapshot.data!;
                                                          final containerUsersRecord =
                                                              containerUsersRecordList
                                                                      .isNotEmpty
                                                                  ? containerUsersRecordList
                                                                      .first
                                                                  : null;
                                                          return Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          8.0,
                                                                          12.0,
                                                                          8.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        pasadosSearchItem
                                                                            .imagenRef,
                                                                        'https://app.vinglet.com/default-image.png',
                                                                      ),
                                                                      width:
                                                                          70.0,
                                                                      height:
                                                                          70.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              pasadosSearchItem.nombreSorteo,
                                                                              'NoData',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  fontSize: 22.0,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                                                                                ),
                                                                          ),
                                                                          Text(
                                                                            valueOrDefault<String>(
                                                                              'Ganador: ${valueOrDefault<String>(
                                                                                containerUsersRecord?.displayName,
                                                                                'Actualizando datos...',
                                                                              )}',
                                                                              'Ganador: [user]',
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  fontSize: 14.0,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                ),
                                                                          ),
                                                                          Text(
                                                                            'Valor: ${valueOrDefault<String>(
                                                                              'Valor: ${valueOrDefault<String>(
                                                                                formatNumber(
                                                                                  pasadosSearchItem.valorSorteo,
                                                                                  formatType: FormatType.decimal,
                                                                                  currency: '€',
                                                                                ),
                                                                                '€',
                                                                              )}',
                                                                              '€',
                                                                            )}',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  fontSize: 14.0,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => SorteoUsersListWidget(
                                                                                  usersInLottery: pasadosSearchItem.reference,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.listOl,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).grayIcon,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              );
                                            },
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
                    ),
                    if(dorpDownValue == "Cuenta regresive")
                      Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Sorteo2").orderBy('endTime',descending: true).snapshots(),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(child: Text("Loading"),);
                              }
                              if(snapshot.connectionState == ConnectionState.active){
                                return ListView(
                                  children: snapshot.data!.docs.map((e){
                                    Map<String,dynamic> drawData = e.data();
                                    DocumentReference docRef = drawData['ref'];
                                    Timestamp? createTime = drawData["createAt"];
                                    DateTime? createAt;
                                    if(createTime != null){
                                      createAt = createTime.toDate();
                                    }
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
                                                          Text("Valor: \$${drawData['value']}"),
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
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                5.0),
                                                            child:
                                                            Text(
                                                              'identificación: ${drawData['uid']}',
                                                              textAlign: TextAlign.start,
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                fontSize: 14.0,
                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                              ),
                                                            ),
                                                          ),
                                                          if(createAt != null)
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                                                                  alignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  child: Text("${createAt.hour}:${createAt.minute} ${createAt.year}/${createAt.month}/${createAt.day}"),
                                                                )
                                                              ],
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
                                            SizedBox(width: 20,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(drawData['name']??"",style: FlutterFlowTheme.of(context).titleMedium,),
                                                  SizedBox(height: 5,),
                                                  Text("Valor: \$${drawData['value']}"),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        0.0,
                                                        5.0),
                                                    child:
                                                    Text(
                                                      'identificación: ${drawData['uid']}',
                                                      textAlign: TextAlign.start,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                        fontSize: 14.0,
                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(height: 20,),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> EditDraw2(drawRef: drawData['ref'])));
                                                        },
                                                        child: Icon(Icons.edit,color: FlutterFlowTheme.of(context).accent3,),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DrawParticipantList(drawRef: drawData['ref'])));
                                                        },
                                                        child: FaIcon(
                                                          FontAwesomeIcons.listOl,
                                                          color:
                                                          FlutterFlowTheme.of(context).accent3,
                                                          size:
                                                          24.0,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                                        },
                                                        child: Icon(Icons.person_add_alt_1_rounded,color: FlutterFlowTheme.of(context).accent3,),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      InkWell(
                                                        onTap: ()async{
                                                          print("lskdjf");
                                                          DocumentReference drawRef = drawData['ref'];
                                                          await drawRef.update({
                                                            'status': false,
                                                          });
                                                          Fluttertoast.showToast(msg: "El sorteo está deshabilitado ahora");
                                                        },
                                                        child: Icon(Icons.delete_forever,color: FlutterFlowTheme.of(context).accent3,),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Text(drawData['status']?"Open":"Close"),
                                          ],
                                        ),
                                      );
                                    }
                                  }).toList(),
                                );
                              }
                              return Center(child: Text("No Draw found"),);

                            },
                          )
                      ),
                    if(dorpDownValue == "Elige tu numero de la suerte")
                      Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Sorteo3").snapshots(),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(child: Text("Loading"),);
                              }
                              if(snapshot.connectionState == ConnectionState.active){
                                return ListView(
                                  children: snapshot.data!.docs.map((e){
                                    Map<String,dynamic> drawData = e.data();
                                    DocumentReference docRef = drawData['ref'];
                                    Timestamp? createTime = drawData["createAt"];
                                    DateTime? createAt;
                                    if(createTime != null){
                                      createAt = createTime.toDate();
                                    }
                                    if(drawData['winner'] != null){
                                      return FutureBuilder(future: getWinnerData(drawData['winner']),
                                          builder: (context, winnerSnapshot){
                                            if(winnerSnapshot.data == null){
                                              return SizedBox();
                                            }
                                            if(winnerSnapshot.connectionState == ConnectionState.done){
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
                                                      height: 70,
                                                      width: 100,
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Image.network(drawData['image'],fit: BoxFit.cover,)),
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(drawData['name']??"",style: FlutterFlowTheme.of(context).labelLarge,),
                                                          SizedBox(height: 5,),
                                                          Text("Valor: \$${drawData['value']}",style: TextStyle(
                                                            color: FlutterFlowTheme.of(context).accent3,
                                                          ),),
                                                          SizedBox(height: 7,),
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
                                                          Row(
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
                                                              Text(drawData['WinnerTicket'].toString(),style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Color.fromARGB(
                                                                      255,
                                                                      245,
                                                                      161,
                                                                      3)
                                                              ),),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                5.0),
                                                            child:
                                                            Text(
                                                              'identificación: ${drawData['uid']}',
                                                              textAlign: TextAlign.start,
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                fontSize: 14.0,
                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                              ),
                                                            ),
                                                          ),
                                                          if(createAt != null)
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                                                                  alignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  child: Text("${createAt.hour}:${createAt.minute} ${createAt.year}/${createAt.month}/${createAt.day}"),
                                                                )
                                                              ],
                                                            ),
                                                          // IconButton(onPressed: (){
                                                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                                          // }, icon: Icon(Icons.person_add_alt_1_rounded)),
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
                                                          //         Navigator.push(context, MaterialPageRoute(builder: (context) => Draw3ParticipantList(drawRef: drawData['ref'])));
                                                          //       },
                                                          //       child: FaIcon(
                                                          //         FontAwesomeIcons.listOl,
                                                          //         color:
                                                          //         FlutterFlowTheme.of(context).accent3,
                                                          //         size:
                                                          //         24.0,
                                                          //       ),
                                                          //     )
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
                                              height: 70,
                                              width: 100,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.network(drawData['image'],fit: BoxFit.cover,)),
                                            ),
                                            SizedBox(width: 20,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(drawData['name']??"",style: FlutterFlowTheme.of(context).labelLarge,),
                                                  SizedBox(height: 5,),
                                                  Text("Valor: \$${drawData['value']}",style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).accent3,
                                                  ),),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        0.0,
                                                        5.0),
                                                    child:
                                                    Text(
                                                      'identificación: ${drawData['uid']}',
                                                      textAlign: TextAlign.start,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                        fontSize: 14.0,
                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 7,),
                                                  // IconButton(onPressed: (){
                                                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                                  // }, icon: Icon(Icons.person_add_alt_1_rounded)),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> EditDraw2(drawRef: drawData['ref'])));
                                                        },
                                                        child: Icon(Icons.edit,color: FlutterFlowTheme.of(context).accent3,),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Draw3ParticipantList(drawRef: drawData['ref'])));
                                                        },
                                                        child: FaIcon(
                                                          FontAwesomeIcons.listOl,
                                                          color:
                                                          FlutterFlowTheme.of(context).accent3,
                                                          size:
                                                          24.0,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo3(Drawref: drawData['ref'])));
                                                        },
                                                        child: Icon(Icons.person_add_alt_1_rounded,color: FlutterFlowTheme.of(context).accent3,),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      InkWell(
                                                        onTap: ()async{
                                                          DocumentReference drawRef = drawData['ref'];
                                                          await drawRef.update({
                                                            'status': false,
                                                          });
                                                        },
                                                        child: Icon(Icons.delete_forever,color: FlutterFlowTheme.of(context).accent3,),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    // return Container(
                                    //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    //   margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(10),
                                    //       color: FlutterFlowTheme.of(context).secondaryBackground,
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //             color: FlutterFlowTheme.of(context).neon,
                                    //             blurRadius: 10,
                                    //             spreadRadius: 5
                                    //         )
                                    //       ],
                                    //       border: Border.all(
                                    //           color: Colors.white,
                                    //           width: 2
                                    //       )
                                    //   ),
                                    //   child: Row(
                                    //     children: [
                                    //       SizedBox(
                                    //         height: 70,
                                    //         width: 100,
                                    //         child: ClipRRect(
                                    //             borderRadius: BorderRadius.circular(10),
                                    //             child: Image.network(drawData['image'],fit: BoxFit.cover,)),
                                    //       ),
                                    //       SizedBox(width: 20,),
                                    //       Expanded(
                                    //         child: Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             Text(drawData['name']??"",style: FlutterFlowTheme.of(context).labelLarge,),
                                    //             SizedBox(height: 5,),
                                    //             Text("Volver: \$${drawData['value']}",style: TextStyle(
                                    //             color: FlutterFlowTheme.of(context).accent3,
                                    //             ),),
                                    //             SizedBox(height: 7,),
                                    //             // IconButton(onPressed: (){
                                    //             //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                    //             // }, icon: Icon(Icons.person_add_alt_1_rounded)),
                                    //             Row(
                                    //               children: [
                                    //                 InkWell(
                                    //                   onTap: (){
                                    //                     Navigator.push(context, MaterialPageRoute(builder: (context)=> EditDraw2(drawRef: drawData['ref'])));
                                    //                   },
                                    //                   child: Icon(Icons.edit,color: FlutterFlowTheme.of(context).accent3,),
                                    //                 ),
                                    //                 SizedBox(width: 10,),
                                    //                 InkWell(
                                    //                   onTap: (){
                                    //                     Navigator.push(context, MaterialPageRoute(builder: (context) => Draw3ParticipantList(drawRef: drawData['ref'])));
                                    //                   },
                                    //                   child: FaIcon(
                                    //                     FontAwesomeIcons.listOl,
                                    //                     color:
                                    //                     FlutterFlowTheme.of(context).accent3,
                                    //                     size:
                                    //                     24.0,
                                    //                   ),
                                    //                 )
                                    //               ],
                                    //             )
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       Text(drawData['status']?"Open":"Close"),
                                    //     ],
                                    //   ),
                                    // );
                                  }).toList(),
                                );
                              }
                              return Center(child: Text("No Draw found"),);

                            },
                          )
                      ),
                    if(dorpDownValue == "Sorteo privado")
                      Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Sorteo4").snapshots(),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(child: Text("Loading"),);
                              }
                              if(snapshot.connectionState == ConnectionState.active){
                                return ListView(
                                  children: snapshot.data!.docs.map((e){
                                    Map<String,dynamic> drawData = e.data();
                                    DocumentReference docRef = drawData['ref'];
                                    Timestamp? createTime = drawData["createAt"];
                                    DateTime? createAt;
                                    if(createTime != null){
                                      createAt = createTime.toDate();
                                    }
                                    if(drawData['winner'] != null){
                                      DocumentReference docRef = drawData['ref'];
                                      return FutureBuilder(future: getWinnerData(drawData['winner']),
                                          builder: (context, winnerSnapshot){
                                            if(winnerSnapshot.data == null){
                                              return SizedBox();
                                            }
                                            if(winnerSnapshot.connectionState == ConnectionState.done){
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
                                                      height: 70,
                                                      width: 100,
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Image.network(drawData['image'],fit: BoxFit.cover,)),
                                                    ),
                                                    SizedBox(width: 20,),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(drawData['name']??"",style: FlutterFlowTheme.of(context).labelLarge,),
                                                          SizedBox(height: 5,),
                                                          Text("Valor: \$${drawData['value']}",style: TextStyle(
                                                            color: FlutterFlowTheme.of(context).accent3,
                                                          ),),
                                                          SizedBox(height: 7,),
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
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                5.0),
                                                            child:
                                                            Text(
                                                              'identificación: ${drawData['uid']}',
                                                              textAlign: TextAlign.start,
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: 'Montserrat',
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                fontSize: 14.0,
                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                              ),
                                                            ),
                                                          ),

                                                          if(createAt != null)
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                                                                  alignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  child: Text("${createAt.hour}:${createAt.minute} ${createAt.year}/${createAt.month}/${createAt.day}"),
                                                                )
                                                              ],
                                                            ),
                                                          // IconButton(onPressed: (){
                                                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                                          // }, icon: Icon(Icons.person_add_alt_1_rounded)),
                                                          // Row(
                                                          //   children: [
                                                          //     InkWell(
                                                          //       onTap: (){
                                                          //         Navigator.push(context, MaterialPageRoute(builder: (context)=> EditDraw4(drawRef: drawData['ref'])));
                                                          //       },
                                                          //       child: Icon(Icons.edit,color: FlutterFlowTheme.of(context).accent3,),
                                                          //     ),
                                                          //     SizedBox(width: 10,),
                                                          //     InkWell(
                                                          //       onTap: (){
                                                          //         Navigator.push(context, MaterialPageRoute(builder: (context) => Draw4ParticipantList(drawRef: drawData['ref'])));
                                                          //       },
                                                          //       child: FaIcon(
                                                          //         FontAwesomeIcons.listOl,
                                                          //         color:
                                                          //         FlutterFlowTheme.of(context).accent3,
                                                          //         size:
                                                          //         24.0,
                                                          //       ),
                                                          //     )
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
                                              height: 70,
                                              width: 100,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.network(drawData['image'],fit: BoxFit.cover,)),
                                            ),
                                            SizedBox(width: 20,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(drawData['name']??"",style: FlutterFlowTheme.of(context).labelLarge,),
                                                  SizedBox(height: 5,),
                                                  Text("Valor: \$${drawData['value']}",style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).accent3,
                                                  ),),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        0.0,
                                                        5.0),
                                                    child:
                                                    Text(
                                                      'identificación: ${drawData['uid']}',
                                                      textAlign: TextAlign.start,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                        fontSize: 14.0,
                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 7,),
                                                  // IconButton(onPressed: (){
                                                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                                  // }, icon: Icon(Icons.person_add_alt_1_rounded)),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> EditDraw4(drawRef: drawData['ref'])));
                                                        },
                                                        child: Icon(Icons.edit,color: FlutterFlowTheme.of(context).accent3,),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DrawParticipantList(drawRef: drawData['ref'])));
                                                        },
                                                        child: FaIcon(
                                                          FontAwesomeIcons.listOl,
                                                          color:
                                                          FlutterFlowTheme.of(context).accent3,
                                                          size:
                                                          24.0,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo4(Drawref: drawData['ref'])));
                                                        },
                                                        child: Icon(Icons.person_add_alt_1_rounded,color: FlutterFlowTheme.of(context).accent3,),
                                                      ),
                                                      SizedBox(width: 10,),
                                                      InkWell(
                                                        onTap: ()async{
                                                          DocumentReference drawRef = drawData['ref'];
                                                          await drawRef.update({
                                                            'status': false,
                                                          });
                                                        },
                                                        child: Icon(Icons.delete_forever,color: FlutterFlowTheme.of(context).accent3,),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            // Text(drawData['status']?"Open":"Close"),
                                          ],
                                        ),
                                      );

                                    }

                                    // return Container(
                                    //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    //   margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(10),
                                    //       color: FlutterFlowTheme.of(context).secondaryBackground,
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //             color: FlutterFlowTheme.of(context).neon,
                                    //             blurRadius: 10,
                                    //             spreadRadius: 5
                                    //         )
                                    //       ],
                                    //       border: Border.all(
                                    //           color: Colors.white,
                                    //           width: 2
                                    //       )
                                    //   ),
                                    //   child: Row(
                                    //     children: [
                                    //       SizedBox(
                                    //         height: 70,
                                    //         width: 100,
                                    //         child: ClipRRect(
                                    //             borderRadius: BorderRadius.circular(10),
                                    //             child: Image.network(drawData['image'],fit: BoxFit.cover,)),
                                    //       ),
                                    //       SizedBox(width: 20,),
                                    //       Expanded(
                                    //         child: Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             Text(drawData['name']??"",style: FlutterFlowTheme.of(context).labelLarge,),
                                    //             SizedBox(height: 5,),
                                    //             Text("Volver: \$${drawData['value']}",style: TextStyle(
                                    //               color: FlutterFlowTheme.of(context).accent3,
                                    //             ),),
                                    //             SizedBox(height: 7,),
                                    //             // IconButton(onPressed: (){
                                    //             //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserSorteo2(Drawref: drawData['ref'])));
                                    //             // }, icon: Icon(Icons.person_add_alt_1_rounded)),
                                    //             Row(
                                    //               children: [
                                    //                 InkWell(
                                    //                   onTap: (){
                                    //                     Navigator.push(context, MaterialPageRoute(builder: (context)=> EditDraw4(drawRef: drawData['ref'])));
                                    //                   },
                                    //                   child: Icon(Icons.edit,color: FlutterFlowTheme.of(context).accent3,),
                                    //                 ),
                                    //                 SizedBox(width: 10,),
                                    //                 InkWell(
                                    //                   onTap: (){
                                    //                     Navigator.push(context, MaterialPageRoute(builder: (context) => Draw4ParticipantList(drawRef: drawData['ref'])));
                                    //                   },
                                    //                   child: FaIcon(
                                    //                     FontAwesomeIcons.listOl,
                                    //                     color:
                                    //                     FlutterFlowTheme.of(context).accent3,
                                    //                     size:
                                    //                     24.0,
                                    //                   ),
                                    //                 )
                                    //               ],
                                    //             )
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       Text(drawData['status']?"Open":"Close"),
                                    //     ],
                                    //   ),
                                    // );

                                  }).toList(),
                                );
                              }
                              return Center(child: Text("No Draw found"),);

                            },
                          )
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
