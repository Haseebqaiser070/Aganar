import 'package:audioplayers/audioplayers.dart';
// import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../admin/sorteo_backend/sorteo_handler.dart';
import '../../backend/push_notifications/push_notifications_util.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_confirm_review/custom_confirm_review_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'sorteo_v2_model.dart';
export 'sorteo_v2_model.dart';
import 'dart:math' as math;

class SorteoV2Widget extends StatefulWidget {
  const SorteoV2Widget({
    Key? key,
    this.sorteoRuleta,
  }) : super(key: key);

  final DocumentReference? sorteoRuleta;

  @override
  _SorteoV2WidgetState createState() => _SorteoV2WidgetState();
}

class _SorteoV2WidgetState extends State<SorteoV2Widget>
    with TickerProviderStateMixin {
  late VideoPlayerController winnervideoPlayerController;
  final player = AudioPlayer();
  final playerBackground = AudioPlayer();
  final wajaBackgroundPlayer = AudioPlayer();
  final clapBackgroundPlayer = AudioPlayer();
  final ballonPlayer = AudioPlayer();
  late SorteoV2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasContainerTriggered1 = false;
  var hasContainerTriggered2 = false;
  var hasButtonTriggered1 = false;
  var hasButtonTriggered2 = false;
  var hasContainerTriggered3 = false;
  final animationsMap = {
    'containerOnActionTriggerAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnActionTriggerAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        ScaleEffect(
          curve: Curves.elasticOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 0.0),
          end: Offset(1.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 50.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'buttonOnActionTriggerAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 300.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'buttonOnActionTriggerAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 300.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnActionTriggerAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1.0,
          end: 0.0,
        ),
      ],
    ),
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.bounceOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'buttonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 300.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };
  late UsersRecord containerPart2UsersRecordGlobal;
  late var stackSorteosRecord;
  late DocumentReference winnerUserReference;
  String winnerPrize = "Cash";
  bool flag = false;
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    getWinner(widget.sorteoRuleta!);
    videoPlayerController =
        VideoPlayerController.asset("assets/videos/landVideo.mp4")
          ..initialize().then((value) {});

    handleMusic();
    _model = createModel(context, () => SorteoV2Model());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

    if (FFAppState().seeWinner) {
      setState(() {
        flag = true;
        print("FFAppState().seeWinner");
        print(FFAppState().seeWinner);
      });
    }

    winnervideoPlayerController =
    VideoPlayerController.asset("assets/videos/countwinner.mp4")..initialize().then((value) {});
  }

  handleMusic() async {
    print("play");
    playerBackground.play(AssetSource("audios/winner.mp3"), volume: 0.2);
    playerBackground.onPlayerComplete.listen((event) {
      playerBackground.play(AssetSource("audios/winner.mp3"), volume: 0.2);
    });
  }

  stopAllMusic() {
    player.stop();
    playerBackground.stop();
    wajaBackgroundPlayer.stop();
    clapBackgroundPlayer.stop();
    ballonPlayer.stop();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final lottieAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    final confetti1AnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    final confettiAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    final celebrateAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    return StreamBuilder<List<SelectedTicketsRecord>>(
      stream: querySelectedTicketsRecord(
        parent: widget.sorteoRuleta,
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
        List<SelectedTicketsRecord> sorteoV2SelectedTicketsRecordList =
            snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
                top: true,
                child: Stack(
                  children: [

                    if(flag)
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: winnervideoPlayerController.value.isInitialized
                                ? AspectRatio(
                              aspectRatio:
                              winnervideoPlayerController.value.aspectRatio,
                              child:  winnervideoPlayerController.value.isInitialized
                                  ? AspectRatio(
                                aspectRatio:
                                winnervideoPlayerController.value.aspectRatio,
                                child: VideoPlayer(winnervideoPlayerController),
                              )
                                  : SizedBox(),
                            )
                                : SizedBox(),
                          ),
                          // winner name and home button
                          // if (FFAppState().seePrize)
                            StreamBuilder<List<UsersRecord>>(
                              stream: queryUsersRecord(
                                queryBuilder: (usersRecord) => usersRecord.where(
                                    'uid',
                                    isEqualTo: sorteoV2SelectedTicketsRecordList
                                    //     .where((e) =>
                                    // e
                                    //     .numTicket == 1
                                    //   // stackSorteosRecord
                                    //   //     .numGanador
                                    // )
                                        .toList()
                                        .first
                                        .usuario
                                        ?.id !=
                                        ''
                                        ? sorteoV2SelectedTicketsRecordList
                                    //     .where((e) =>
                                    // e.numTicket == 1
                                    //   // stackSorteosRecord
                                    //   //     .numGanador
                                    // )
                                        .toList()
                                        .first
                                        .usuario
                                        ?.id
                                        : null),
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
                                        color:
                                        FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 26.0,
                                      ),
                                    ),
                                  );
                                }

                                List<UsersRecord>
                                containerPart2UsersRecordList =
                                snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container(child: Text("non"),);
                                }
                                // int winnerNumber = math.Random().nextInt(snapshot.data!.length);
                                // final containerPart2UsersRecord =
                                //     containerPart2UsersRecordList.isNotEmpty
                                //         ? containerPart2UsersRecordList[winnerNumber]
                                //         : null;

                                late UsersRecord
                                containerPart2UsersRecord;

                                for (UsersRecord userRecord
                                in containerPart2UsersRecordList) {
                                  if (userRecord.reference ==
                                      winnerUserReference) {
                                    containerPart2UsersRecord =
                                        userRecord;
                                    containerPart2UsersRecordGlobal = userRecord;
                                  }
                                }

                                return Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    // gradient: LinearGradient(
                                    //   colors: [
                                    //     Color(0xFFDC4E2B),
                                    //     Color(0xFFDE542C),
                                    //     Color(0xFFC71A2C)
                                    //   ],
                                    //   stops: [0.0, 0.5, 1.0],
                                    //   begin: AlignmentDirectional(
                                    //       0.0, -1.0),
                                    //   end: AlignmentDirectional(0, 1.0),
                                    // ),
                                  ),
                                  child: Column(
                                    // mainAxisSize: MainAxisSize.max,
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                        300.0,
                                        decoration:
                                        BoxDecoration(
                                          color: Color(
                                              0x4DF1F4F8),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          border:
                                          Border.all(
                                            color:
                                            FlutterFlowTheme.of(context).primaryBackground,
                                          ),
                                        ),
                                        child:
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              8.0,
                                              8.0,
                                              8.0,
                                              8.0),
                                          child:
                                          Row(
                                            mainAxisSize:
                                            MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Image.network(
                                                    valueOrDefault<String>(
                                                      containerPart2UsersRecord?.photoUrl,
                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ruleta-izygr8/assets/gk8cg20c6m84/woman_avaatr.png',
                                                    ),
                                                    width: 60.0,
                                                    height: 60.0,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                      child: Text(
                                                        containerPart2UsersRecord!.displayName,
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                          color: Colors.white,
                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                      child: Text(
                                                        containerPart2UsersRecord!.email,
                                                        style: FlutterFlowTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Montserrat',
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                      child: Text(
                                                        'Con el emoji: ${stackSorteosRecord.selectedTickets[0]}',
                                                        // 'Con el emoji: ${stackSorteosRecord.selectedTickets[stackSorteosRecord.numGanador]}',
                                                        style: FlutterFlowTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Montserrat',
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          fontWeight: FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
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
                                      FFButtonWidget(
                                        onPressed: () async {
                                          stopAllMusic();

                                          await stackSorteosRecord
                                              .reference
                                              .update({
                                            // ...createSorteosRecordData(
                                            //   ganador:
                                            //   containerPart2UsersRecord
                                            //       ?.reference,
                                            // ),
                                            'jugoSorteo':
                                            FieldValue
                                                .arrayUnion([
                                              currentUserReference
                                            ]),
                                          });
                                          await closeSorteo(widget
                                              .sorteoRuleta!);
                                          await showModalBottomSheet(
                                            isScrollControlled:
                                            true,
                                            backgroundColor:
                                            Colors
                                                .transparent,
                                            isDismissible:
                                            false,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () => FocusScope.of(
                                                    context)
                                                    .requestFocus(
                                                    _model
                                                        .unfocusNode),
                                                child: Padding(
                                                  padding: MediaQuery
                                                      .viewInsetsOf(
                                                      context),
                                                  child:
                                                  CustomConfirmReviewWidget(
                                                    title:
                                                    'Comentarios',
                                                    body:
                                                    'Deseas dejarnos un comentario?',
                                                    activeSorteo:
                                                    stackSorteosRecord
                                                        .reference,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) =>
                                              setState(() {
                                                FFAppState()
                                                    .seePrize =
                                                false;
                                                FFAppState()
                                                    .seePrize =
                                                false;
                                                FFAppState()
                                                    .seeVideo =
                                                false;
                                                FFAppState()
                                                    .seeWinner =
                                                false;

                                              }));
                                        },
                                        text:
                                        'Volver al Inicio',
                                        icon: Icon(
                                          Icons.home_filled,
                                          size: 15.0,
                                        ),
                                        options:
                                        FFButtonOptions(
                                          width: 230.0,
                                          height: 55.0,
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
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .primary,
                                          textStyle:
                                          FlutterFlowTheme.of(
                                              context)
                                              .titleSmall
                                              .override(
                                            fontFamily:
                                            'Montserrat',
                                            color: Colors
                                                .white,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                FlutterFlowTheme.of(context).titleSmallFamily),
                                          ),
                                          elevation: 2.0,
                                          borderSide:
                                          BorderSide(
                                            color: Colors
                                                .transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              16.0),
                                        ),
                                      ).animateOnActionTrigger(
                                          animationsMap[
                                          'buttonOnActionTriggerAnimation2']!,
                                          hasBeenTriggered:
                                          hasButtonTriggered2),
                                    ],
                                  ),
                                ).animateOnActionTrigger(
                                    animationsMap[
                                    'containerOnActionTriggerAnimation1']!,
                                    hasBeenTriggered:
                                    hasContainerTriggered1);
                              },
                            ),
                        ],
                      ),

                    if (FFAppState().seePrize)
                      StreamBuilder<List<UsersRecord>>(
                        stream: queryUsersRecord(
                          queryBuilder: (usersRecord) => usersRecord.where(
                              'uid',
                              isEqualTo: sorteoV2SelectedTicketsRecordList
                              //     .where((e) =>
                              // e
                              //     .numTicket == 1
                              //   // stackSorteosRecord
                              //   //     .numGanador
                              // )
                                  .toList()
                                  .first
                                  .usuario
                                  ?.id !=
                                  ''
                                  ? sorteoV2SelectedTicketsRecordList
                              //     .where((e) =>
                              // e.numTicket == 1
                              //   // stackSorteosRecord
                              //   //     .numGanador
                              // )
                                  .toList()
                                  .first
                                  .usuario
                                  ?.id
                                  : null),
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
                                  color:
                                  FlutterFlowTheme.of(context)
                                      .primary,
                                  size: 26.0,
                                ),
                              ),
                            );
                          }


                          List<UsersRecord>
                          containerPart2UsersRecordList =
                          snapshot.data!;
                          // Return an empty Container when the item does not exist.
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          }
                          // int winnerNumber = math.Random().nextInt(snapshot.data!.length);
                          // final containerPart2UsersRecord =
                          //     containerPart2UsersRecordList.isNotEmpty
                          //         ? containerPart2UsersRecordList[winnerNumber]
                          //         : null;

                          late UsersRecord
                          containerPart2UsersRecord;

                          for (UsersRecord userRecord
                          in containerPart2UsersRecordList) {
                            if (userRecord.reference ==
                                winnerUserReference) {
                              containerPart2UsersRecord =
                                  userRecord;
                              containerPart2UsersRecordGlobal = userRecord;
                            }
                          }

                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      70.0,
                                      68.0,
                                      8.0,
                                      0),
                                  child:
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network(
                                            valueOrDefault<String>(
                                              containerPart2UsersRecord?.photoUrl,
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ruleta-izygr8/assets/gk8cg20c6m84/woman_avaatr.png',
                                            ),
                                            width: 60.0,
                                            height: 60.0,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                              child: Text(
                                                containerPart2UsersRecord!.displayName,
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0),
                                              child: Text(
                                                containerPart2UsersRecord!.email,
                                                style: FlutterFlowTheme.of(context).titleSmall.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${stackSorteosRecord.selectedTickets[0]}',
                                  // 'Con el emoji: ${stackSorteosRecord.selectedTickets[stackSorteosRecord.numGanador]}',
                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 66.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                    if (FFAppState().seePrize)
                      Positioned(
                        bottom: 30,
                        left: 85,
                        child: FFButtonWidget(
                          onPressed: () async {
                            stopAllMusic();

                            await stackSorteosRecord
                                .reference
                                .update({
                              // ...createSorteosRecordData(
                              //   ganador:
                              //   containerPart2UsersRecord
                              //       ?.reference,
                              // ),
                              'jugoSorteo':
                              FieldValue
                                  .arrayUnion([
                                currentUserReference
                              ]),
                            });
                            await closeSorteo(widget
                                .sorteoRuleta!);
                            await showModalBottomSheet(
                              isScrollControlled:
                              true,
                              backgroundColor:
                              Colors
                                  .transparent,
                              isDismissible:
                              false,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => FocusScope.of(
                                      context)
                                      .requestFocus(
                                      _model
                                          .unfocusNode),
                                  child: Padding(
                                    padding: MediaQuery
                                        .viewInsetsOf(
                                        context),
                                    child:
                                    CustomConfirmReviewWidget(
                                      title:
                                      'Comentarios',
                                      body:
                                      'Deseas dejarnos un comentario?',
                                      activeSorteo:
                                      stackSorteosRecord
                                          .reference,
                                    ),
                                  ),
                                );
                              },
                            ).then((value) =>
                                setState(() {
                                  FFAppState()
                                      .seePrize =
                                  false;
                                  FFAppState()
                                      .seePrize =
                                  false;
                                  FFAppState()
                                      .seeVideo =
                                  false;
                                  FFAppState()
                                      .seeWinner =
                                  false;

                                }));
                          },
                          text:
                          'Volver al Inicio',
                          icon: Icon(
                            Icons.home_filled,
                            size: 15.0,
                          ),
                          options:
                          FFButtonOptions(
                            width: 230.0,
                            height: 55.0,
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
                            color: FlutterFlowTheme
                                .of(context)
                                .primary,
                            textStyle:
                            FlutterFlowTheme.of(
                                context)
                                .titleSmall
                                .override(
                              fontFamily:
                              'Montserrat',
                              color: Colors
                                  .white,
                              useGoogleFonts: GoogleFonts
                                  .asMap()
                                  .containsKey(
                                  FlutterFlowTheme.of(context).titleSmallFamily),
                            ),
                            elevation: 2.0,
                            borderSide:
                            BorderSide(
                              color: Colors
                                  .transparent,
                              width: 1.0,
                            ),
                            borderRadius:
                            BorderRadius
                                .circular(
                                16.0),
                          ),
                        ).animateOnActionTrigger(
                            animationsMap[
                            'buttonOnActionTriggerAnimation2']!,
                            hasBeenTriggered:
                            hasButtonTriggered2),
                      ),



                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: StreamBuilder<SorteosRecord>(
                            stream:
                                SorteosRecord.getDocument(widget.sorteoRuleta!),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 26.0,
                                    height: 26.0,
                                    child: SpinKitDoubleBounce(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 26.0,
                                    ),
                                  ),
                                );
                              }
                              stackSorteosRecord = snapshot.data!;
                              return Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    if (!FFAppState().spinRoulette)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          constraints: BoxConstraints(
                                            maxWidth: 500.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).primaryBackground
                                            // gradient: LinearGradient(
                                            //   colors: [
                                            //     Color(0xFFDC4E2B),
                                            //     Color(0xFFDE542C),
                                            //     Color(0xFFC71A2C)
                                            //   ],
                                            //   stops: [0.0, 0.5, 1.0],
                                            //   begin: AlignmentDirectional(
                                            //       0.0, -1.0),
                                            //   end: AlignmentDirectional(0, 1.0),
                                            // ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 56.0, 16.0, 46.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Inicia el sorteo',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                                color: Colors
                                                                    .white,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleLargeFamily),
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 75.0,
                                                      height: 75.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      2.0,
                                                                      2.0,
                                                                      2.0,
                                                                      2.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          60.0),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  currentUserPhoto,
                                                                  'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                                                ),
                                                                width: 100.0,
                                                                height: 100.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  0.0,
                                                                  0.0),
                                                      child:
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            Text(
                                                          currentUserDisplayName,
                                                          maxLines: 1,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily,
                                                                color: Colors
                                                                    .white,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Participaras junto a todos ellos para llevarte el premio',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .white,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 16.0,
                                                                0.0, 16.0),
                                                    child: StreamBuilder<
                                                        List<UsersRecord>>(
                                                      stream: queryUsersRecord(
                                                        queryBuilder: (usersRecord) => usersRecord.whereIn(
                                                            'uid',
                                                            sorteoV2SelectedTicketsRecordList
                                                                        .map((e) => e
                                                                            .usuario
                                                                            ?.id)
                                                                        .withoutNulls
                                                                        .toList() !=
                                                                    ''
                                                                ? sorteoV2SelectedTicketsRecordList
                                                                    .map((e) => e
                                                                        .usuario
                                                                        ?.id)
                                                                    .withoutNulls
                                                                    .toList()
                                                                : null),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
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
                                                            gridViewUsersRecordList =
                                                            snapshot.data!
                                                                .where((u) =>
                                                                    u.uid !=
                                                                    currentUserUid)
                                                                .toList();
                                                        return GridView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            crossAxisSpacing:
                                                                10.0,
                                                            mainAxisSpacing:
                                                                10.0,
                                                            childAspectRatio:
                                                                1.0,
                                                          ),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              gridViewUsersRecordList
                                                                  .length,
                                                          itemBuilder: (context,
                                                              gridViewIndex) {
                                                            final gridViewUsersRecord =
                                                                gridViewUsersRecordList[
                                                                    gridViewIndex];
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: 75.0,
                                                                  height: 70.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Card(
                                                                    clipBehavior:
                                                                        Clip.antiAliasWithSaveLayer,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          2.0,
                                                                          2.0,
                                                                          2.0,
                                                                          2.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(60.0),
                                                                        child: Image
                                                                            .network(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            gridViewUsersRecord.photoUrl,
                                                                            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                                                          ),
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              100.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    gridViewUsersRecord
                                                                        .displayName,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines: 1,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).titleSmallFamily,
                                                                          color:
                                                                              Colors.white,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        // boxShadow: [
                                                        //   BoxShadow(
                                                        //     blurRadius: 64.0,
                                                        //     color: Color(
                                                        //         0x68F1F4F8),
                                                        //     spreadRadius: 16.0,
                                                        //   )
                                                        // ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          if(stackSorteosRecord != null){

                                                            setState(() {
                                                              FFAppState()
                                                                  .seeVideo =
                                                              true;
                                                              videoPlayerController
                                                                  .play();
                                                            });

                                                            await Future.delayed(
                                                                Duration(
                                                                    seconds: 8));
                                                            setState(() {
                                                              FFAppState()
                                                                  .seeVideo =
                                                              false;
                                                              videoPlayerController.dispose();
                                                              FFAppState()
                                                                  .seeCount =
                                                              true;

                                                            });
                                                            setState(() {
                                                              FFAppState()
                                                                  .seeCount =
                                                              false;
                                                            });

                                                            // videoPlayerController.addListener(() {
                                                            //   if(videoPlayerController.value.isCompleted){
                                                            //     print("calling jugar");
                                                            //     Calljugar();
                                                            //   }
                                                            // });

                                                            // await Future.delayed(Duration(seconds: 10));
                                                            // setState(() {
                                                            //   FFAppState().seeVideo = false;
                                                            // });

                                                            //TODO
                                                            if (animationsMap[
                                                            'containerOnActionTriggerAnimation3'] !=
                                                                null) {
                                                              print("one");
                                                              setState(() =>
                                                              hasContainerTriggered3 =
                                                              true);
                                                              SchedulerBinding
                                                                  .instance
                                                                  .addPostFrameCallback((_) async => animationsMap[
                                                              'containerOnActionTriggerAnimation3']!
                                                                  .controller
                                                                  .forward(
                                                                  from:
                                                                  0.0));
                                                            }
                                                            setState(() {
                                                              FFAppState()
                                                                  .spinRoulette =
                                                              true;
                                                            });
                                                            if (animationsMap[
                                                            'containerOnActionTriggerAnimation1'] !=
                                                                null) {
                                                              print("two");
                                                              setState(() =>
                                                              hasContainerTriggered1 =
                                                              true);
                                                              SchedulerBinding
                                                                  .instance
                                                                  .addPostFrameCallback((_) async => animationsMap[
                                                              'containerOnActionTriggerAnimation1']!
                                                                  .controller
                                                                  .forward(
                                                                  from:
                                                                  0.0));
                                                            }

                                                            //++++++++**********************
                                                            print("//++++++++**********************");
                                                            setState(() {
                                                              flag = true;
                                                              print("animation start..");
                                                            });
                                                            winnervideoPlayerController.play();
                                                            await Future.delayed(Duration(seconds: 3));
                                                            await wajaBackgroundPlayer
                                                                .play(AssetSource(
                                                                "audios/waja.mp3"));
                                                            confetti1AnimationController
                                                                .forward();
                                                            player.play(AssetSource(
                                                                "audios/blast.mp3"));
                                                            confettiAnimationController
                                                                .forward();
                                                            confettiAnimationController
                                                                .addListener(
                                                                    () {
                                                                  if (confettiAnimationController
                                                                      .isCompleted) {
                                                                    confettiAnimationController
                                                                        .reverse();
                                                                    confettiAnimationController
                                                                        .reset();
                                                                  }
                                                                });

                                                            await lottieAnimationController
                                                                .forward();
                                                            lottieAnimationController
                                                                .dispose();

                                                            // await Future.delayed(
                                                            //     const Duration(
                                                            //         milliseconds:
                                                            //             4000));

                                                            celebrateAnimationController
                                                                .forward();
                                                            ballonPlayer.play(
                                                                AssetSource(
                                                                    "audios/ballon.mp3"));
                                                            celebrateAnimationController
                                                                .reset();

                                                            if (containerPart2UsersRecordGlobal
                                                                .reference ==
                                                                currentUserReference) {

                                                              //TODO
                                                              await sendNotification(
                                                                  currentUserReference!,
                                                                  "Eres ganadora",
                                                                  "Felicidades");
                                                              triggerPushNotification(
                                                                notificationTitle:
                                                                'Eres ganadora',
                                                                notificationText:
                                                                'Felicidades.',
                                                                notificationSound:
                                                                'default',
                                                                userRefs: [currentUserReference!],
                                                                initialPageName:
                                                                'notifications',
                                                                parameterData: {},
                                                              );
                                                            }
                                                            // setState(() {
                                                            //   FFAppState()
                                                            //       .seeWinner =
                                                            //   true;
                                                            // });

                                                            // await Future.delayed(
                                                            //     Duration(
                                                            //         milliseconds:
                                                            //         100));
                                                            // setState(() {
                                                            //   flag = true;
                                                            //   print("animation start");
                                                            //   print(flag
                                                            //       .toString());
                                                            // });

                                                            await confetti1AnimationController
                                                                .forward();

                                                            // rocketAnimationController.reset();
                                                            clapBackgroundPlayer
                                                                .play(AssetSource(
                                                                "audios/clap.mp3"));

                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                'sorteos')
                                                                .doc(widget
                                                                .sorteoRuleta!
                                                                .id)
                                                                .update({
                                                              'timer': false,
                                                            });

                                                            // if (containerPart2UsersRecordGlobal
                                                            //     .reference ==
                                                            //     currentUserReference) {
                                                            setState(() {
                                                              FFAppState()
                                                                  .seePrize =
                                                              true;
                                                            });
                                                            // }
                                                            //*********************
                                                          }
                                                        },
                                                        text: 'Comenzar',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 230.0,
                                                          height: 55.0,
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent3,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleSmallFamily),
                                                                  ),
                                                          elevation: 2.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                        ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'buttonOnPageLoadAnimation']!),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ).animateOnPageLoad(animationsMap[
                                                'columnOnPageLoadAnimation']!),
                                          ),
                                        ).animateOnActionTrigger(
                                            animationsMap[
                                                'containerOnActionTriggerAnimation3']!,
                                            hasBeenTriggered:
                                                hasContainerTriggered3),
                                      ),

                                    //winner prize show text
                                    // if (FFAppState().seePrize)
                                    //   ClipRRect(
                                    //     borderRadius: BorderRadius.circular(5),
                                    //     child: Container(
                                    //       width: MediaQuery.of(context).size.width,
                                    //       height: MediaQuery.of(context).size.height,
                                    //       alignment: Alignment.center,
                                    //       child: Column(
                                    //         mainAxisAlignment: MainAxisAlignment.start,
                                    //         children: [
                                    //           SizedBox(height: 30,),
                                    //           Text(
                                    //             "Winner prize is $winnerPrize.",
                                    //             style: TextStyle(
                                    //               color: Colors.white,
                                    //               fontWeight: FontWeight.bold,
                                    //               fontSize: 22,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),




                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    // if (FFAppState().seeVideo)
                    //   ClipRRect(
                    //     borderRadius: BorderRadius.circular(5),
                    //     child: Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       height: MediaQuery.of(context).size.height,
                    //       child: videoPlayerController.value.isInitialized
                    //           ? AspectRatio(
                    //               aspectRatio:
                    //                   videoPlayerController.value.aspectRatio,
                    //               child: VideoPlayer(videoPlayerController),
                    //             )
                    //           : SizedBox(),
                    //     ),
                    //   ),

                    if (FFAppState().seeVideo)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: videoPlayerController.value.isInitialized
                              ? AspectRatio(
                            aspectRatio:
                            videoPlayerController.value.aspectRatio,
                            child:  videoPlayerController.value.isInitialized
                                      ? AspectRatio(
                                          aspectRatio:
                                              videoPlayerController.value.aspectRatio,
                                          child: VideoPlayer(videoPlayerController),
                                        )
                                      : SizedBox(),
                          )
                              : SizedBox(),
                        ),
                      ),



                    // if (FFAppState().seePrize)
                    //   ClipRRect(
                    //     borderRadius: BorderRadius.circular(5),
                    //     child: Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       height: MediaQuery.of(context).size.height,
                    //       alignment: Alignment.center,
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           SizedBox(height: 5,),
                    //           Text(
                    //             "Congratulations you win $winnerPrize.",
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 18,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 20,
                    //           ),
                    //           Image.asset(
                    //             "assets/images/$winnerPrize.png",
                    //             height: 200,
                    //             width: 200,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                  ],
                )),
          ),
        );
      },
    );
  }

  Future getWinner(DocumentReference sorteoRef) async {
    print("geet winner starting");
    winnerUserReference = await FirebaseFirestore.instance
        .collection('sorteos')
        .doc(sorteoRef.id)
        .get()
        .then((value) => value.data()!['ganador']);
    winnerPrize = await FirebaseFirestore.instance
        .collection('sorteos')
        .doc(sorteoRef.id)
        .get()
        .then((value) => value.data()!['prize']);
  }

  Future closeSorteo(DocumentReference sorteoRef) async {
    List jugoSorteo = await FirebaseFirestore.instance
        .collection('sorteos')
        .doc(sorteoRef.id)
        .get()
        .then((value) => value.data()!['jugoSorteo']);
    int limiteParticipant = await FirebaseFirestore.instance
        .collection('sorteos')
        .doc(sorteoRef.id)
        .get()
        .then((value) => value.data()!['limite_participantes']);

    if (jugoSorteo.length == limiteParticipant ||
        jugoSorteo.length >= limiteParticipant) {
      await FirebaseFirestore.instance
          .collection('sorteos')
          .doc(sorteoRef.id)
          .update({
        'estado_sorteo': false,
      });
    }
  }
}
