import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorteoaganar/admin/SendAdminNotification/sendNotification.dart';
import 'package:sorteoaganar/admin/createDrawMode2/CreateDrawMode2.dart';
import 'package:sorteoaganar/admin/createDrawMode3/CreateDrawMode3.dart';
import 'package:sorteoaganar/admin/createPrivateDraw/createPrivateDraw.dart';
import 'package:sorteoaganar/admin/sorteo_backend/sorteo_handler.dart';
import 'package:sorteoaganar/admin/uploadVideo/uploadVideo.dart';
import 'package:sorteoaganar/backend/user_status_location/UserStatusLocation.dart';
import 'package:sorteoaganar/inapp%20purchase/CustomPurchase.dart';
import 'package:sorteoaganar/user/Draw2Detail/Draw2Detail.dart';
import 'package:sorteoaganar/user/ShowTicketList4/ShowticketList4.dart';
import '../../backend/cloud_functions/cloud_functions.dart';
import '../../backend/push_notifications/push_notifications_util.dart';
import '../Draw3Detail/Draw3Detail.dart';
import '../PrivateDrawAllParticipant/PrivateDrawAllParticipant.dart';
import '../ShowAllParticipant/ShowAllParticipant.dart';
import '/admin/admin_sorteos/admin_sorteos_widget.dart';
import '/admin/crear_sorteo/crear_sorteo_widget.dart';
import '/admin/users_list/users_list_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/nav_bar_floting/nav_bar_floting_widget.dart';
import '/components/no_data/no_data_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/app_reviews/app_reviews_widget.dart';
import '/user/detalles/detalles_widget.dart';
import '/user/historico/historico_widget.dart';
import '/user/lista_sorteos/lista_sorteos_widget.dart';
import '/user/notifications/notifications_widget.dart';
import '/user/perfil/perfil_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'inicio_model.dart';
export 'inicio_model.dart';
import 'dart:math' as math;

final audioPlayer = AudioPlayer();



class InicioWidget extends StatefulWidget {
  const InicioWidget({Key? key}) : super(key: key);

  @override
  _InicioWidgetState createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late InicioModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool music;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    // start background audio
    startMusic();
    _model = createModel(context, () => InicioModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

    if (valueOrDefault<bool>(currentUserDocument?.isAdmin, false)) {
      // getActiveSorteo();
      // callCloudFunction();
    }
    // handleMusic();
    WidgetsBinding.instance.addObserver(this);
    handleUserStatus();
    print("online");
    goOnline(true);
    printToken();
  }


  Future printToken()async{
    print("**********get token");
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    print(await firebaseMessaging.getToken());
    print("**********get token");
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future goOnline(bool online) async {
    firestore
        .collection("users")
        .doc(currentUserUid)
        .update({
      'online': online,
      'lastseen': FieldValue.serverTimestamp(),
    }).then((value) {
      print("Going Online $online");
    }).catchError((e) {
      print(e);
    });
  }

  // This method is called when the app's lifecycle state changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.hidden) {
      // App is in the foreground (opened)
      print("App hidden");
      goOnline(false);
      // Add your code to run when the app is opened here.
      stopMusic();
    }
    if (state == AppLifecycleState.inactive) {
      // App is in the foreground (opened)
      print("App inactive");
      goOnline(false);
      // Add your code to run when the app is opened here.
      stopMusic();
    }
    if (state == AppLifecycleState.resumed) {
      // App is in the foreground (opened)
      print("App resumed");
      goOnline(true);// Add your code to run when the app is opened here.
      startMusic();
    } else if (state == AppLifecycleState.paused) {
      // App is in the background (closed)
      print("App pasued");
      goOnline(false);
      // Add your code to run when the app is closed here.
      stopMusic();
    }
  }

  @override
  void dispose() {
    _model.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }




  startMusic(){
    if(audioPlayer.state != PlayerState.playing){
      audioPlayer.play(AssetSource("audios/music.mp3"), volume: 0.2);
      audioPlayer.onPlayerStateChanged.listen((event) {
        if(event == PlayerState.completed){
          audioPlayer.play(AssetSource("audios/music.mp3"), volume: 0.2);
        }
      });
    }
  }


  stopMusic(){
    if(audioPlayer.state == PlayerState.playing){
      audioPlayer.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<SorteosRecord>>(
      stream: querySorteosRecord(),
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
        List<SorteosRecord> inicioSorteosRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            // appBar: AppBar(
            //   actions: [
            //     IconButton(onPressed: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => CustomPurchase()));
            //     }, icon: Icon(Icons.add_a_photo_sharp))
            //   ],
            // ),
            endDrawer: Drawer(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              elevation: 16.0,
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: FlutterFlowTheme.of(context).secondaryBackground,
                    // ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 24.0, 16.0, 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 15.0, 12.0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 120.0,
                                      height: 120.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          'assets/images/a_ganar_logo_grande_sin_fondo.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Text(
                                  'Usuario',
                                  style:
                                      FlutterFlowTheme.of(context).titleSmall,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 0.0, 12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InicioWidget(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 8.0, 12.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.home_filled,
                                          color: FlutterFlowTheme.of(context)
                                              .accent3,
                                          size: 28.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Inicio',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PerfilWidget(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 8.0, 12.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.userCircle,
                                          color: FlutterFlowTheme.of(context)
                                              .accent3,
                                          size: 28.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Perfil',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ListaSorteosWidget(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 8.0, 12.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.list,
                                          color: FlutterFlowTheme.of(context)
                                              .accent3,
                                          size: 28.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Lista de  Sorteos',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AppReviewsWidget(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 8.0, 12.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.rate_review,
                                          color: FlutterFlowTheme.of(context)
                                              .accent3,
                                          size: 28.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Comentarios',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => uploadVideo(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 8.0, 12.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.video_call,
                                          color: FlutterFlowTheme.of(context)
                                              .accent3,
                                          size: 28.0,
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              12.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Upload Video',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                              fontFamily: 'Montserrat',
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleSmallFamily),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            if (valueOrDefault<bool>(
                                currentUserDocument?.isAdmin, false))
                              AuthUserStreamWidget(
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 12.0, 0.0, 0.0),
                                      child: Text(
                                        'Admin',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 12.0, 0.0, 12.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () => showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  title: Text(
                                                    "seleccionar sorteo",
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleMedium,
                                                  ),
                                                  actions: [
                                                    Column(
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CrearSorteoWidget(),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                              "Emoji ganador",
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall,
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CreateDrawMode2(),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                              "Cuenta regresive",
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall,
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                      CreateDrawMode3(),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                              "Elige tu numero de la suerte",
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall,
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                      createPrivateDraw(),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                              "Sorteo privado",
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .titleSmall,
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                        // onTap: () async {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         CrearSorteoWidget(),
                                        //   ),
                                        // );
                                        // },
                                        child: Container(
                                          width: double.infinity,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 8.0, 12.0, 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.add_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent3,
                                                  size: 28.0,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Crear Sorteos',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0, 0.0, 12.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SendAdminNotification()));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 8.0, 12.0, 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.rocket_launch_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent3,
                                                  size: 24.0,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Enviar notificación',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 12.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminSorteosWidget(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 8.0, 12.0, 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.edit_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent3,
                                                  size: 28.0,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Editar Sorteos',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 12.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UsersListWidget(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 8.0, 12.0, 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.person_outline,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent3,
                                                  size: 28.0,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Usuarios',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Divider(
                                    height: 12.0,
                                    thickness: 2.0,
                                    color:
                                        FlutterFlowTheme.of(context).lineColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 12.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        AuthUserStreamWidget(
                                          builder: (context) => ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                                  Duration(milliseconds: 500),
                                              fadeOutDuration:
                                                  Duration(milliseconds: 500),
                                              imageUrl: valueOrDefault<String>(
                                                currentUserPhoto,
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ruleta-izygr8/assets/gk8cg20c6m84/woman_avaatr.png',
                                              ),
                                              width: 44.0,
                                              height: 44.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AuthUserStreamWidget(
                                                  builder: (context) => Text(
                                                    currentUserDisplayName,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleMedium,
                                                  ),
                                                ),
                                                AuthUserStreamWidget(
                                                  builder: (context) => Text(
                                                    valueOrDefault<bool>(
                                                            currentUserDocument
                                                                ?.isAdmin,
                                                            false)
                                                        ? 'Administrador'
                                                        : 'Usuario',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall,
                                                  ),
                                                ),
                                              ],
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              top: true,
              child: Align(
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 25.0, 16.0, 15.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     blurRadius: 4.0,
                                //     color:
                                //         FlutterFlowTheme.of(context).secondary,
                                //     offset: Offset(0.0, 2.0),
                                //   )
                                // ],
                                shape: BoxShape.circle,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(50.0),
                                      child: Image.asset(
                                        'assets/images/a_ganar_logo_grande_sin_fondo.png',
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: AutoSizeText(
                                  'A Ganar',
                                  textAlign: TextAlign.center,
                                  style:
                                      FlutterFlowTheme.of(context).titleLarge,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 5.0, 0.0),
                                    child: StreamBuilder<
                                        List<NotificacionesRecord>>(
                                      stream: queryNotificacionesRecord(
                                        queryBuilder: (notificacionesRecord) =>
                                            notificacionesRecord.where(
                                                'notifiedUsersList',
                                                arrayContains:
                                                    currentUserReference),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 26.0,
                                              height: 26.0,
                                              child: SpinKitDoubleBounce(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                size: 26.0,
                                              ),
                                            ),
                                          );
                                        }
                                        List<NotificacionesRecord>
                                            containerNotificacionesRecordList =
                                            snapshot.data!;
                                        return Container(
                                          decoration: BoxDecoration(),
                                          child: Stack(
                                            children: [
                                              if (containerNotificacionesRecordList
                                                      .length >
                                                  0)
                                                badges.Badge(
                                                  badgeContent: Text(
                                                    valueOrDefault<String>(
                                                      formatNumber(
                                                        containerNotificacionesRecordList
                                                            .where((e) => !e
                                                                .readingByUser
                                                                .contains(
                                                                    currentUserReference))
                                                            .toList()
                                                            .length,
                                                        formatType:
                                                            FormatType.compact,
                                                      ),
                                                      '0',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                                  ),
                                                  showBadge: true,
                                                  shape:
                                                      badges.BadgeShape.circle,
                                                  badgeColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 4.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 8.0, 8.0, 8.0),
                                                  position: badges.BadgePosition
                                                      .topEnd(),
                                                  animationType: badges
                                                      .BadgeAnimationType.scale,
                                                  toAnimate: true,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NotificationsWidget(),
                                                            ),
                                                          );
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .notifications_active,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          size: 30.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (containerNotificacionesRecordList
                                                      .length <
                                                  1)
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            NotificationsWidget(),
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.notifications_active,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    size: 30.0,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  if (valueOrDefault<bool>(
                                      currentUserDocument?.isAdmin, false))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            scaffoldKey.currentState!
                                                .openEndDrawer();
                                          },
                                          child: Icon(
                                            Icons.menu_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            size: 32.0,
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
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoricoWidget(),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 170.0,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x23000000),
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    FlutterFlowTheme.of(context).primary,
                                    FlutterFlowTheme.of(context).tertiary
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(1.0, -0.5),
                                  end: AlignmentDirectional(-1.0, 0.5),
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 16.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Estas participando por',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(FlutterFlowTheme
                                                              .of(context)
                                                          .headlineSmallFamily),
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 0.0, 0.0),
                                            child: Text(
                                              'Lifting de pertanas valorado en',
                                              maxLines: 2,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0x9AFFFFFF),
                                                    fontSize: 14.0,
                                                    useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                        .containsKey(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily),
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 8.0, 0.0, 0.0),
                                            child: Text(
                                              '€75.00',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white,
                                                        fontSize: 40.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmallFamily),
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 8.0,
                                            color: Color(0x49000000),
                                            offset: Offset(0.0, 2.0),
                                          )
                                        ],
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircularPercentIndicator(
                                        percent: 1.0,
                                        radius: 45.0,
                                        lineWidth: 4.0,
                                        animation: true,
                                        progressColor: Colors.white,
                                        backgroundColor: Color(0x2B202529),
                                        center: Text(
                                          '10/25',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(FlutterFlowTheme
                                                            .of(context)
                                                        .headlineSmallFamily),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 0, 16.0, 16.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListaSorteosWidget(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  'Sorteos Actuales',
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 5.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ListaSorteosWidget(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Ver más',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall),
                                        ),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: FlutterFlowTheme.of(context).secondary,
                                size: 24.0,
                              ),
                            ],
                          ),
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
                          // padding: EdgeInsetsDirectional.fromSTEB(
                          //     16.0, 0.0, 16.0, 5.0),
                          padding: EdgeInsets.all(0),
                          child: Builder(
                            builder: (context) {
                              final listaSorteos = inicioSorteosRecordList
                                  .map((e) => e)
                                  .toList()
                                  .where((e) => e.estadoSorteo == true)
                                  .where((e) => !e.jugoSorteo
                                      .contains(currentUserReference))
                                  .toList()
                                  .take(4)
                                  .toList();
                              if (listaSorteos.isEmpty) {
                                return Center(
                                  child: NoDataWidget(),
                                );
                              }

                              return RefreshIndicator(
                                onRefresh: () async {
                                  await Future.delayed(
                                      const Duration(milliseconds: 2000));
                                },
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 0.6,
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listaSorteos.length,
                                  itemBuilder: (context, listaSorteosIndex) {
                                    final listaSorteosItem =
                                        listaSorteos[listaSorteosIndex];
                                    return FutureBuilder<int>(
                                      future: querySelectedTicketsRecordCount(
                                        parent: listaSorteosItem.reference,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 26.0,
                                              height: 26.0,
                                              child: SpinKitDoubleBounce(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 26.0,
                                              ),
                                            ),
                                          );
                                        }
                                        // handleTimer(listaSorteosItem.timer_end);
                                        CustomTimerController _controller =
                                            CustomTimerController(
                                                vsync: this,
                                                begin: totalTime(
                                                    listaSorteosItem.timer_end),
                                                end: Duration(),
                                                initialState:
                                                    CustomTimerState.reset,
                                                interval: CustomTimerInterval
                                                    .milliseconds);
                                        _controller.start();
                                        int containerCount = snapshot.data!;
                                        return Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.45,
                                          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(255, 249, 43, 249),
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
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 4.0, 4.0, 4.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children:[
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                        borderRadius: BorderRadius.circular(10),
                                                        boxShadow: [
                                                          if(listaSorteosItem.imagenRef != "")
                                                            BoxShadow(color: Color.fromARGB(255, 249, 43, 249),
                                                              blurRadius: 10,
                                                              spreadRadius: 1,
                                                            offset: Offset(0,3))
                                                        ],

                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      child: listaSorteosItem.imagenRef == null ||
                                                              listaSorteosItem
                                                                      .imagenRef ==
                                                                  ""
                                                          ? SizedBox(
                                                              height: 140,
                                                            )
                                                          : Image.network(
                                                        listaSorteosItem.imagenRef,
                                                              width:
                                                                  double.infinity,
                                                              height: 140.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                // if(listaSorteosItem.fechaCreacion != null)
                                                // Row(
                                                //   mainAxisAlignment: MainAxisAlignment.end,
                                                //   children: [
                                                //     Text("${listaSorteosItem.fechaCreacion!.hour}:${listaSorteosItem.fechaCreacion!.minute} ${listaSorteosItem.fechaCreacion!.year}-${listaSorteosItem.fechaCreacion!.month}-${listaSorteosItem.fechaCreacion!.day}",style: FlutterFlowTheme.of(context)
                                                //         .bodySmall
                                                //         .override(
                                                //         fontFamily: 'Montserrat',
                                                //         useGoogleFonts: GoogleFonts
                                                //             .asMap()
                                                //             .containsKey(
                                                //           FlutterFlowTheme.of(
                                                //               context)
                                                //               .bodySmallFamily,),
                                                //         color: FlutterFlowTheme.of(context).accent3,
                                                //         fontSize: 12,
                                                //       fontWeight: FontWeight.w600
                                                //     ),),
                                                //   ],
                                                // ),
                                                if (listaSorteosItem.timer)
                                                  CustomTimer(
                                                      controller: _controller,
                                                      builder: (state, time) {
                                                        // Build the widget you want!🎉
                                                        return Text(
                                                            "${time.minutes}:${time.seconds}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    24.0));
                                                      }),
                                                // Text('Time left:${NumberFormat("00").format(minutes % 60)}:${NumberFormat("00").format(seconds % 60)}',style: FlutterFlowTheme.of(
                                                //     context)
                                                //     .titleSmall),
                                                // if (listaSorteosItem.timer)
                                                //   Text(
                                                //     "${listaSorteosItem.minute} : ${listaSorteosItem.second}",
                                                //     style: TextStyle(
                                                //       fontFamily: 'Montserrat',
                                                //       fontSize: 26,
                                                //       fontWeight:
                                                //           FontWeight.bold,
                                                //     ),
                                                //   ),

                                                Text(
                                                  "${listaSorteosItem.limiteParticipantes-listaSorteosItem.selectedTickets.length} Entradas disponibles.",
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                        .containsKey(
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodySmallFamily,),
                                                    color: FlutterFlowTheme.of(context).accent3,
                                                    fontSize: 12
                                                  ),
                                                ),
                                                Text(
                                                  listaSorteosItem.descripcion
                                                      .maybeHandleOverflow(
                                                    maxChars: 20,
                                                    replacement: '…',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily),
                                                        lineHeight: 1.2,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 2.0, 0.0, 4.0),
                                                  child: Text(
                                                    formatNumber(
                                                      listaSorteosItem
                                                          .valorSorteo,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: '€',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleSmall,
                                                  ),
                                                ),
                                                Spacer(),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(12.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color.fromARGB(255,249, 43, 249),
                                                                  blurRadius: 5,
                                                                  spreadRadius: 2,
                                                                offset: Offset(0,-1)
                                                              )
                                                            ],
                                                            border: Border.all(
                                                                color: Colors.white,
                                                                width: 1
                                                            )
                                                        ),
                                                        child: FFButtonWidget(
                                                          onPressed: containerCount >=
                                                                  listaSorteosItem
                                                                      .limiteParticipantes
                                                              ? () async {
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              DetallesWidget(
                                                                        sorteo: listaSorteosItem
                                                                            .reference,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              : () async {
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              DetallesWidget(
                                                                        sorteo: listaSorteosItem
                                                                            .reference,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                          text: valueOrDefault<
                                                              String>(
                                                            containerCount >=
                                                                    listaSorteosItem
                                                                        .limiteParticipantes
                                                                ? 'Sorteo en Curso!'
                                                                : 'Saber más',
                                                            'Saber más',
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            height: 35.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        0.0,
                                                                        24.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: Colors
                                                                          .white,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).titleSmallFamily),
                                                                    ),
                                                            elevation: 1.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            disabledColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .lineColor,
                                                          ),
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
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if(dorpDownValue == "Cuenta regresive")
                        Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Sorteo2").where('status', isEqualTo: true).snapshots(),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(
                                  child: SizedBox(
                                    width: 26.0,
                                    height: 26.0,
                                    child: SpinKitDoubleBounce(
                                      color:
                                      FlutterFlowTheme.of(context)
                                          .primary,
                                      size: 26.0,
                                    ),
                                  ),
                                );
                              }
                          if(snapshot.connectionState == ConnectionState.active){
                            var edt = snapshot.data!.docs;
                            List refineList = [];
                            for(QueryDocumentSnapshot qds in snapshot.data!.docs){
                              if(!qds['seeWinner'].contains(currentUserReference)){
                                refineList.add(qds);
                              }
                            }
                            if(refineList.length == 0){
                              return NoDataWidget();
                            }



                            return GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: (100/205),
                              children: refineList.map((e){
                                // if(e.data()['seeWinner'].contains(currentUserReference))
                                //   return SizedBox();
                                Map<String,dynamic> draw = e.data();
                                DateTime endTime = e.data()['endTime'].toDate();
                                DateTime timerendtime = endTime.add(Duration(minutes: 3));
                                DateTime currentTime = DateTime.now();
                                // CustomTimerController _timercController;
                                // if(currentTime.compareTo(timerendtime)>=1 && timerendtime.compareTo(currentTime) >=1){
                                CustomTimerController _timercController =
                                  CustomTimerController(
                                      vsync: this,
                                      begin: totalTime(
                                          endTime),
                                      end: Duration(),
                                      initialState:
                                      CustomTimerState.reset,
                                      interval: CustomTimerInterval
                                          .milliseconds);
                                _timercController.start();
                                // }

                                Timestamp? createTime = draw["createAt"];
                                DateTime? createAt;
                                if(createTime != null){
                                  createAt = createTime.toDate();
                                }
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius:
                                    BorderRadius.circular(12.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(255, 249, 43, 249),
                                            blurRadius: 10,
                                            spreadRadius: 5
                                        )
                                      ],
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 2
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromARGB(255, 249, 43, 249),
                                                    blurRadius: 10,
                                                    spreadRadius: 1,
                                                    offset: Offset(0,3)
                                                )
                                              ],

                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              child: draw['image'] ==
                                                  null ||
                                                  draw['image'] ==
                                                      ""
                                                  ? SizedBox(
                                                height: 160,
                                              )
                                                  : Image.network(
                                                draw['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if(createAt != null)
                                        Padding(
                                          padding: EdgeInsets.only(right: 3),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text("${createAt.hour}:${createAt.minute} ${createAt.year}-${createAt.month}-${createAt.day}",style: FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .override(
                                                  fontFamily: 'Montserrat',
                                                  useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                      .containsKey(
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodySmallFamily,),
                                                  color: FlutterFlowTheme.of(context).accent3,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            ],
                                          ),
                                        ),


                                        draw['timer'] == true && draw['participants'].contains(currentUserReference)?
                                        CustomTimer(
                                            controller: _timercController,
                                            builder: (state, time) {
                                              // Build the widget you want!🎉
                                              return Text(
                                                  "${time.minutes}:${time.seconds}",
                                                  style: TextStyle(
                                                      fontSize:
                                                      24.0));
                                            })
                                            :SizedBox(height: 28,),
                                      Text(
                                        "Entradas disponibles ${10000-draw['soldTickets'].length}",
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                            fontFamily: 'Montserrat',
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodySmallFamily,),
                                            color: FlutterFlowTheme.of(context).accent3,
                                            fontSize: 12
                                        ),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Hora de finalización:  ${endTime.hour} : ${endTime.minute}",style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                              fontFamily: 'Montserrat',
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodySmallFamily,),
                                              color: FlutterFlowTheme.of(context).accent3,
                                              fontSize: 12
                                          ),),
                                        ],
                                      ),
                                      Text(
                                        draw['name'],
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .titleSmall
                                            .override(
                                          fontFamily:
                                          'Montserrat',
                                          useGoogleFonts: GoogleFonts
                                              .asMap()
                                              .containsKey(
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleSmallFamily),
                                          lineHeight: 1.2,
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(
                                            0.0, 4.0, 0.0, 4.0),
                                        child: Text(
                                          formatNumber(
                                            draw['value'],
                                            formatType:
                                            FormatType.decimal,
                                            decimalType:
                                            DecimalType.automatic,
                                            currency: '€',
                                          ),
                                          style: FlutterFlowTheme.of(
                                              context)
                                              .titleSmall,
                                        ),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          if(draw['participants'].contains(currentUserReference)){
                                              if(draw['timer'] == false){
                                                // draw not finish yet but user participating in draw
                                                Fluttertoast.showToast(msg: "El sorteo aún no ha terminado..");
                                                return;
                                              }
                                              if(draw['timer'] == true){
                                                // timer has bee started of user draw
                                                DateTime drawendtime = draw["endTime"].toDate();
                                                DateTime timerEndTime = drawendtime.add(Duration(minutes: 3));
                                                print(timerEndTime);
                                                print(timerEndTime.compareTo(DateTime.now()));

                                                if(timerEndTime.compareTo(DateTime.now()) == -1){
                                                  // user can see winner now
                                                  print("see winner");
                                                  if(draw["winner"]!= null){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllParticipant(drawRef: draw['ref'])));
                                                  }
                                                  else{
                                                    int number = math.Random().nextInt(draw['participants'].length);
                                                    print(number);
                                                    firestore.collection("Sorteo2").doc(draw['uid']).update({
                                                      'winner': draw['participants'][number]
                                                    }).then((value){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllParticipant(drawRef: draw['ref'])));
                                                    });
                                                  }


                                                  return;
                                                }else{
                                                  Fluttertoast.showToast(msg: "Espere a que finalice el cronómetro.");
                                                  return;
                                                }
                                              }

                                          }
                                          else if(draw['timer'] == false){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Draw2Detail(drawid: draw['uid'])));
                                          }
                                          else{
                                            Fluttertoast.showToast(msg: "El tiempo del sorteo ha terminado.");
                                          }

                                          },
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromARGB(255,249, 43, 249),
                                                    blurRadius: 5,
                                                    spreadRadius: 2,
                                                    // offset: Offset(0,-1)
                                                )
                                              ],
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1
                                              )
                                          ),
                                          alignment: Alignment.center,
                                          child: Text("Sorteo en Curso",style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                                return Center(
                                  child: NoDataWidget(),
                                );
                            },
                          ),
                        ),
                      if(dorpDownValue == "Elige tu numero de la suerte")
                        Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Sorteo3").where('status', isEqualTo: true).snapshots(),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(
                                  child: SizedBox(
                                    width: 26.0,
                                    height: 26.0,
                                    child: SpinKitDoubleBounce(
                                      color:
                                      FlutterFlowTheme.of(context)
                                          .primary,
                                      size: 26.0,
                                    ),
                                  ),
                                );
                              }
                              if(snapshot.data!.docs.length == 0){
                                return NoDataWidget();
                              }
                              if(snapshot.connectionState == ConnectionState.active){

                                List<QueryDocumentSnapshot<Map<String, dynamic>>> refineList = [];
                                snapshot.data!.docs.map((e){
                                  if(!e.data()['seeWinner'].contains(currentUserReference)){
                                    print(e.toString());
                                    refineList.add(e);
                                  }
                                }).toList();
                                return GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: (100/205),
                                  children: refineList.map((e){
                                    // if(e.data()['seeWinner'].contains(currentUserReference))
                                    //   return SizedBox();
                                    Map<String,dynamic> draw = e.data();
                                    DateTime endTime = e.data()['endTime'].toDate();
                                    DateTime timerendtime = endTime.add(Duration(minutes: 3));
                                    DateTime currentTime = DateTime.now();
                                    // CustomTimerController _timercController;
                                    // if(currentTime.compareTo(timerendtime)>=1 && timerendtime.compareTo(currentTime) >=1){
                                    CustomTimerController _timercController =
                                    CustomTimerController(
                                        vsync: this,
                                        begin: totalTime(
                                            endTime),
                                        end: Duration(),
                                        initialState:
                                        CustomTimerState.reset,
                                        interval: CustomTimerInterval
                                            .milliseconds);
                                    _timercController.start();
                                    // }

                                    Timestamp? createTime = draw["createAt"];
                                    DateTime? createAt;
                                    if(createTime != null){
                                      createAt = createTime.toDate();
                                    }
                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(255, 249, 43, 249),
                                                blurRadius: 10,
                                                spreadRadius: 5
                                            )
                                          ],
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 2
                                          )
                                      ),
                                      child: Column(
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: 200,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                      borderRadius: BorderRadius.circular(10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color.fromARGB(255, 249, 43, 249),
                                                            blurRadius: 10,
                                                            spreadRadius: 1,
                                                            offset: Offset(0,3)
                                                        )
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(10.0),
                                                      child: draw['image'] ==
                                                          null ||
                                                          draw['image'] ==
                                                              ""
                                                          ? SizedBox(
                                                        height: 160,
                                                      )
                                                          : Image.network(
                                                        draw['image'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (valueOrDefault<bool>(currentUserDocument?.isAdmin, false))
                                              IconButton(onPressed: ()async{
                                                DocumentReference drawRef = draw['ref'];
                                                await drawRef.update({
                                                  'status': false,
                                                });
                                              }, icon: Icon(Icons.delete,color: FlutterFlowTheme.of(context).secondaryBackground,)),
                                            ],
                                          ),

                                          // if(createAt != null)
                                          //   Padding(
                                          //     padding: EdgeInsets.only(right: 3),
                                          //     child: Row(
                                          //       mainAxisAlignment: MainAxisAlignment.end,
                                          //       children: [
                                          //         Text("${createAt.hour}:${createAt.minute} ${createAt.year}-${createAt.month}-${createAt.day}",style: FlutterFlowTheme.of(context)
                                          //             .bodySmall
                                          //             .override(
                                          //             fontFamily: 'Montserrat',
                                          //             useGoogleFonts: GoogleFonts
                                          //                 .asMap()
                                          //                 .containsKey(
                                          //               FlutterFlowTheme.of(
                                          //                   context)
                                          //                   .bodySmallFamily,),
                                          //             color: FlutterFlowTheme.of(context).accent3,
                                          //             fontSize: 12,
                                          //             fontWeight: FontWeight.w600
                                          //         ),),
                                          //       ],
                                          //     ),
                                          //   ),

                                          draw['timer'] == true && draw['participants'].contains(currentUserReference)?
                                            CustomTimer(
                                                controller: _timercController,
                                                builder: (state, time) {
                                                  // Build the widget you want!🎉
                                                  return Text(
                                                      "${time.minutes}:${time.seconds}",
                                                      style: TextStyle(
                                                          fontSize:
                                                          24.0));
                                                })
                                              :SizedBox(height: 29,),

                                          Text(
                                            "Entradas disponibles ${10000-draw['soldTickets'].length}",
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                fontFamily: 'Montserrat',
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodySmallFamily,),
                                                color: FlutterFlowTheme.of(context).accent3,
                                                fontSize: 12
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Draw End Time:  ${endTime.hour} : ${endTime.minute}",style: FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .override(
                                                  fontFamily: 'Montserrat',
                                                  useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                      .containsKey(
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodySmallFamily,),
                                                  color: FlutterFlowTheme.of(context).accent3,
                                                  fontSize: 12
                                              ),),
                                            ],
                                          ),
                                          Text(
                                            draw['name'],
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .titleSmall
                                                .override(
                                              fontFamily:
                                              'Montserrat',
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleSmallFamily),
                                              lineHeight: 1.2,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(
                                                0.0, 3.0, 0.0, 4.0),
                                            child: Text(
                                              formatNumber(
                                                draw['value'],
                                                formatType:
                                                FormatType.decimal,
                                                decimalType:
                                                DecimalType.automatic,
                                                currency: '€',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .titleSmall,
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              if(draw['participants'].contains(currentUserReference)){
                                                if(draw['winner'] != null){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllParticipant(drawRef: draw['ref'])));
                                                }else{
                                                  Fluttertoast.showToast(msg: "El sorteo aún no ha terminado.");
                                                }

                                              }
                                              else if(draw['winner'] == null){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Draw3Detail(drawid: draw['uid'])));
                                              }
                                              else{
                                                Fluttertoast.showToast(msg: "Draw has been finished.");
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(255,249, 43, 249),
                                                      blurRadius: 5,
                                                      spreadRadius: 2,
                                                      // offset: Offset(0,-1)
                                                    )
                                                  ],
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1
                                                  )
                                              ),
                                              alignment: Alignment.center,
                                              child: Text("Sorteo en Curso",style: TextStyle(
                                                color: Colors.white,
                                              ),),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                );
                              }
                              return Center(
                                child: NoDataWidget(),
                              );
                            },
                          ),
                        ),
                      if(dorpDownValue == "Sorteo privado")
                        Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Sorteo4").where('status', isEqualTo: true).snapshots(),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(
                                  child: SizedBox(
                                    width: 26.0,
                                    height: 26.0,
                                    child: SpinKitDoubleBounce(
                                      color:
                                      FlutterFlowTheme.of(context)
                                          .primary,
                                      size: 26.0,
                                    ),
                                  ),
                                );
                              }
                              if(snapshot.data!.docs.length == 0){
                                return NoDataWidget();
                              }
                              if(snapshot.connectionState == ConnectionState.active){

                                List<QueryDocumentSnapshot<Map<String, dynamic>>> refineList = [];
                                snapshot.data!.docs.map((e){
                                  if(!e.data()['seeWinner'].contains(currentUserReference)){
                                    print(e.toString());
                                    refineList.add(e);
                                  }
                                }).toList();

                                return GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: (100/190),
                                  children: refineList.map((e){
                                    // if(e.data()['seeWinner'].contains(currentUserReference))
                                    //   return SizedBox();
                                    Map<String,dynamic> draw = e.data();
                                    DateTime endTime = draw['endTime'].toDate();
                                    CustomTimerController _timercController =
                                    CustomTimerController(
                                        vsync: this,
                                        begin: totalTime(
                                            endTime),
                                        end: Duration(),
                                        initialState:
                                        CustomTimerState.reset,
                                        interval: CustomTimerInterval
                                            .milliseconds);
                                    _timercController.start();


                                    Timestamp? createTime = draw["createAt"];
                                    DateTime? createAt;
                                    if(createTime != null){
                                      createAt = createTime.toDate();
                                    }

                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(255, 249, 43, 249),
                                                blurRadius: 10,
                                                spreadRadius: 5
                                            )
                                          ],
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 2
                                          )
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            height: 200,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromARGB(255, 249, 43, 249),
                                                        blurRadius: 10,
                                                        spreadRadius: 1,
                                                        offset: Offset(0,3)
                                                    )
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                  child: draw['image'] ==
                                                      null ||
                                                      draw['image'] ==
                                                          ""
                                                      ? SizedBox(
                                                    height: 160,
                                                  )
                                                      : Image.network(
                                                    draw['image'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // if(createAt != null)
                                          //   Padding(
                                          //     padding: EdgeInsets.only(right: 3),
                                          //     child: Row(
                                          //       mainAxisAlignment: MainAxisAlignment.end,
                                          //       children: [
                                          //         Text("${createAt.hour}:${createAt.minute} ${createAt.year}-${createAt.month}-${createAt.day}",style: FlutterFlowTheme.of(context)
                                          //             .bodySmall
                                          //             .override(
                                          //             fontFamily: 'Montserrat',
                                          //             useGoogleFonts: GoogleFonts
                                          //                 .asMap()
                                          //                 .containsKey(
                                          //               FlutterFlowTheme.of(
                                          //                   context)
                                          //                   .bodySmallFamily,),
                                          //             color: FlutterFlowTheme.of(context).accent3,
                                          //             fontSize: 12,
                                          //             fontWeight: FontWeight.w600
                                          //         ),),
                                          //       ],
                                          //     ),
                                          //   ),

                                          draw['timer'] == true && draw['participants'].contains(currentUserReference)?
                                            CustomTimer(
                                                controller: _timercController,
                                                builder: (state, time) {
                                                  // Build the widget you want!🎉
                                                  return Text(
                                                      "${time.minutes}:${time.seconds}",
                                                      style: TextStyle(
                                                          fontSize:
                                                          24.0));
                                                })
                                              :SizedBox(height: 40,),
                                          Text(
                                            "${draw['limite']-draw['soldTickets'].length} Entradas disponibles.",
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                fontFamily: 'Montserrat',
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodySmallFamily,),
                                                color: FlutterFlowTheme.of(context).accent3,
                                                fontSize: 12
                                            ),
                                          ),
                                          Text(
                                            draw['name'],
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .titleSmall
                                                .override(
                                              fontFamily:
                                              'Montserrat',
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleSmallFamily),
                                              lineHeight: 1.2,
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              TextEditingController codeC = TextEditingController();
                                              showModalBottomSheet(context: context,
                                                  isScrollControlled: true,
                                                  builder: (context){
                                                return Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                                  margin: EdgeInsets.only(
                                                      bottom: MediaQuery.of(context).viewInsets.bottom),
                                                  height: 300,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(20))
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 20,),
                                                      Text("introduzca el código",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18
                                                      ),),
                                                      SizedBox(height: 20,),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                            16.0, 16.0, 16.0, 0.0),
                                                        child: TextFormField(
                                                          controller: codeC,
                                                          decoration: InputDecoration(
                                                            labelText: 'introduzca el código',
                                                            labelStyle: TextStyle(
                                                              color: Colors.black45
                                                            ),
                                                            hintText: 'introduce el código privado',
                                                            hintStyle:  TextStyle(

                                                            ),

                                                            enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: FlutterFlowTheme.of(context)
                                                                    .secondaryBackground,
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
                                                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                                                20.0, 32.0, 20.0, 12.0),
                                                          ),
                                                          style: FlutterFlowTheme.of(context)
                                                              .headlineSmall
                                                              .override(
                                                            fontFamily: 'Montserrat',
                                                            useGoogleFonts: GoogleFonts.asMap()
                                                                .containsKey(FlutterFlowTheme.of(context)
                                                                .headlineSmallFamily),
                                                            color: Colors.black
                                                          ),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ),

                                                      SizedBox(height: 20,),
                                                      InkWell(
                                                        onTap: ()async{
                                                          if(codeC.text == draw['code']){
                                                            if(draw['participants'].contains(currentUserReference)){
                                                              if(draw['timer'] == true){
                                                                DateTime timerEnd = endTime.add(Duration(minutes: 3));
                                                                print(timerEnd);
                                                                print(DateTime.now());
                                                                print(DateTime.now().compareTo(timerEnd));
                                                                if(DateTime.now().compareTo(timerEnd) == 1){
                                                                  if(draw['winner'] != null){
                                                                    print("show winner1");
                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateDrawAllParticipant(drawRef: draw['ref'],)));
                                                                  }
                                                                  else{
                                                                    List participants = draw['participants'];
                                                                    int winnerIndex = math.Random().nextInt(participants.length);
                                                                    DocumentReference drawRef = draw['ref'];
                                                                    await drawRef.update({
                                                                      'winner': participants[winnerIndex]
                                                                    });
                                                                    print("show winner2");
                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateDrawAllParticipant(drawRef: draw['ref'],)));
                                                                  }
                                                                }
                                                                else{
                                                                  Fluttertoast.showToast(msg: "Wait for timer end.");
                                                                  Navigator.pop(context);
                                                                }
                                                              }
                                                              else{
                                                                Fluttertoast.showToast(msg: "Draw has not finish yet.");
                                                                Navigator.pop(context);
                                                              }
                                                            }
                                                            else{
                                                              if(draw['winner'] != null || draw['timer'] == true){
                                                                Fluttertoast.showToast(msg: "Draw has been ended.");
                                                                Navigator.pop(context);
                                                              }
                                                              else{
                                                                // await jointDraw4(draw['ref']);
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowTicketList4(sorteo: draw,)));

                                                              }
                                                            }
                                                          }
                                                          else{
                                                            Fluttertoast.showToast(msg: "Code is invalide");
                                                            Navigator.pop(context);
                                                          }
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: FlutterFlowTheme.of(context).secondaryBackground,

                                                          ),
                                                          child: Text("ingresar",style: TextStyle(
                                                            color: Colors.white,
                                                          ),),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(255,249, 43, 249),
                                                      blurRadius: 5,
                                                      spreadRadius: 2,
                                                      // offset: Offset(0,-1)
                                                    )
                                                  ],
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1
                                                  )
                                              ),
                                              alignment: Alignment.center,
                                              child: Text("Sorteo en Curso",style: TextStyle(
                                                color: Colors.white,
                                              ),),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                );
                              }
                              return Center(
                                child: NoDataWidget(),
                              );
                            },
                          ),
                        ),

                        if (!valueOrDefault<bool>(
                          currentUserDocument?.isAdmin, false))
                        AuthUserStreamWidget(
                          builder: (context) => wrapWithModel(
                            model: _model.navBarFlotingModel,
                            updateCallback: () => setState(() {}),
                            updateOnChange: true,
                            child: NavBarFlotingWidget(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: ()async{
            //     triggerPushNotification(
            //       notificationTitle:
            //       'Elige Tu Emoji***',
            //       notificationText:
            //       'Elige tu emoji para el sorteo*****',
            //       notificationSound:
            //       'default',
            //       userRefs: [
            //         currentUserReference!
            //       ],
            //       initialPageName:
            //       'notifications',
            //       parameterData: {},
            //     );
            //   },
            //   child: Icon(Icons.add),
            // ),
          ),
        );
      },
    );
  }

  var items = [
    'Emoji ganador',
    'Cuenta regresive',
    'Elige tu numero de la suerte',
    'Sorteo privado'
  ];

  String dorpDownValue = "Emoji ganador";

  int hours = 00;
  int minutes = 00;
  int seconds = 00;

  void handleTimer(DateTime givenDateTime) {
    DateTime endDateTime = givenDateTime.add(Duration(minutes: 3));
    Timer.periodic(Duration(seconds: 1), (timer) {
      final currentDateTime = DateTime.now();
      if (currentDateTime.isBefore(endDateTime)) {
        final difference = endDateTime.difference(currentDateTime);
        // print('Time left: ${difference.inHours}:${difference.inMinutes % 60}:${difference.inSeconds % 60}');
        hours = difference.inHours;
        minutes = difference.inMinutes;
        seconds = difference.inSeconds;
        setState(() {});
      } else {
        timer.cancel();
        // print('Timer expired.');
      }
    });
  }

  Duration totalTime(DateTime givenDateTime) {
    DateTime endDateTime = givenDateTime.add(Duration(minutes: 3));
    final currentDateTime = DateTime.now();
    if (currentDateTime.isBefore(endDateTime)) {
      final difference = endDateTime.difference(currentDateTime);
      return difference;
    } else {
      return Duration(seconds: 0);
    }
  }
  
  
}
