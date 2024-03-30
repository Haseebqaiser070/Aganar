import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorteoaganar/auth/firebase_auth/auth_util.dart';
import 'package:sorteoaganar/index.dart';
import 'package:video_player/video_player.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class Draw2Winner extends StatefulWidget {
  Draw2Winner({Key? key, required this.userRef, required this.drawRef})
      : super(key: key);
  DocumentReference userRef;
  DocumentReference drawRef;

  @override
  State<Draw2Winner> createState() => _Draw2WinnerState();
}

class _Draw2WinnerState extends State<Draw2Winner> {

  final player = AudioPlayer();
  late VideoPlayerController videoPlayerController;
  late VideoPlayerController countVideoPlayerController;
  bool logo = true;
  bool countdown = false;
  bool winner = false;

  int winnerticket = 0;


  Future getWinningNumber()async{

    await widget.drawRef.collection("participant").where('userRef', isEqualTo: widget.userRef).get().then((value){
      winnerticket = value.docs[0].data()['tickets'][0];
    });
    await widget.drawRef.get().then((value){
      Map data =  value.data() as Map;
      if(data['WinnerTicket'] != null){
        winnerticket = data['WinnerTicket'];
      }
    });
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController =
    VideoPlayerController.asset("assets/videos/landVideo.mp4")..initialize().then((value) {});

    countVideoPlayerController = VideoPlayerController.asset("assets/videos/countwinner.mp4")..initialize().then((value) {});
    getWinningNumber();
    handleStates();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
    countVideoPlayerController.dispose();
  }


  Future handleStates()async{


    await videoPlayerController.play();

    await Future.delayed(
        Duration(
            seconds: 1));
    setState(() {

    });
    await Future.delayed(
        Duration(
            seconds: 8));

    setState(() {
      logo = false;
      countdown = true;
      videoPlayerController.dispose();
    });
    await countVideoPlayerController.play();
    await Future.delayed(
        Duration(
            seconds: 5));
    setState(() {
      winner = true;
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => InicioWidget()),
                (route) => false);
          },
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      ),
      body:
        Stack(
          children: [
            // if(winner)
            //   FutureBuilder(
            //     future: getParticipantData(widget.userRef),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //           child: CircularProgressIndicator(
            //             color: FlutterFlowTheme.of(context).secondaryBackground,
            //           ),
            //         );
            //       }
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         return Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               AnimatedAlign(
            //                 duration: Duration(
            //                     seconds:
            //                     2),
            //                 alignment: winner
            //                     ? Alignment(
            //                     0,
            //                     0)
            //                     : Alignment(
            //                     70,
            //                     10),
            //                 curve: Curves
            //                     .bounceInOut,
            //                 child:
            //                 Container(
            //                   width:
            //                   300.0,
            //                   decoration:
            //                   BoxDecoration(
            //                     color: Color(
            //                         0x4DF1F4F8),
            //                     borderRadius:
            //                     BorderRadius.circular(8.0),
            //                     border:
            //                     Border.all(
            //                       color:
            //                       FlutterFlowTheme.of(context).primaryBackground,
            //                     ),
            //                   ),
            //                   child:
            //                   Padding(
            //                     padding: EdgeInsetsDirectional.fromSTEB(
            //                         8.0,
            //                         8.0,
            //                         8.0,
            //                         8.0),
            //                     child:
            //                     Row(
            //                       mainAxisSize:
            //                       MainAxisSize.max,
            //                       children: [
            //                         Padding(
            //                           padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
            //                           child: ClipRRect(
            //                             borderRadius: BorderRadius.circular(8.0),
            //                             child: Image.network(
            //                               valueOrDefault<String>(
            //                                 snapshot.data!['photo_url'],
            //                                 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ruleta-izygr8/assets/gk8cg20c6m84/woman_avaatr.png',
            //                               ),
            //                               width: 60.0,
            //                               height: 60.0,
            //                               fit: BoxFit.fitWidth,
            //                             ),
            //                           ),
            //                         ),
            //                         Padding(
            //                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
            //                           child: Column(
            //                             mainAxisSize: MainAxisSize.max,
            //                             mainAxisAlignment: MainAxisAlignment.center,
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               Padding(
            //                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
            //                                 child: Text(
            //                                   snapshot.data!['display_name'],
            //                                   style: FlutterFlowTheme.of(context).bodyMedium.override(
            //                                     fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
            //                                     color: Colors.white,
            //                                     useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
            //                                   ),
            //                                 ),
            //                               ),
            //                               Padding(
            //                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
            //                                 child: Text(
            //                                   snapshot.data!['email'],
            //                                   style: FlutterFlowTheme.of(context).titleSmall.override(
            //                                     fontFamily: 'Montserrat',
            //                                     color: Colors.white,
            //                                     fontSize: 14.0,
            //                                     fontWeight: FontWeight.normal,
            //                                     useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 20,),
            //               InkWell(
            //                 onTap: ()async{
            //                   int participantlength = 0;
            //                   int seeWinnerlength = 0;
            //
            //                   await widget.drawRef.get().then((value){
            //                     Map data = value.data() as Map;
            //                     seeWinnerlength = data['seeWinner'].length;
            //                     participantlength = data['participants'].length;
            //                   });
            //
            //                   if(snapshot.data!['uid'] == currentUserUid){
            //                     currentUserReference!.update({
            //                       '': currentUserLevel+1,
            //                     });
            //                   }
            //                   if(seeWinnerlength >= participantlength){
            //                     await widget.drawRef.update({
            //                       'status': false
            //                     }).then((value){
            //                       print("All participant have seen winner.");
            //                       print("draw has been ended");
            //                     });
            //                   }
            //                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> InicioWidget()), (route) => false);
            //                 },
            //                 child: Container(
            //                   margin: EdgeInsets.symmetric(horizontal: 20),
            //                   padding: EdgeInsets.symmetric(vertical: 10),
            //                   decoration: BoxDecoration(
            //                       color: FlutterFlowTheme.of(context).secondaryBackground,
            //                       borderRadius: BorderRadius.circular(10)
            //                   ),
            //                   alignment: Alignment.center,
            //                   child: Text("Volver Home"),
            //                 ),
            //               )
            //             ],
            //           ),
            //         );
            //       }
            //       return Text("No Data");
            //     },
            //   ),

            if(logo)
              Container(
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

              Stack(
                children: [
                  if(countdown)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: countVideoPlayerController.value.isInitialized
                        ? AspectRatio(
                      aspectRatio:
                      countVideoPlayerController.value.aspectRatio,
                      child:  countVideoPlayerController.value.isInitialized
                          ? AspectRatio(
                        aspectRatio:
                        countVideoPlayerController.value.aspectRatio,
                        child: VideoPlayer(countVideoPlayerController),
                      )
                          : SizedBox(),
                    )
                        : SizedBox(),
                  ),
                  if(winner)
                  FutureBuilder(
                    future: getParticipantData(widget.userRef),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 330,),
                              AnimatedAlign(
                                duration: Duration(
                                    seconds:
                                    2),
                                alignment: winner
                                    ? Alignment(
                                    0,
                                    0)
                                    : Alignment(
                                    70,
                                    10),
                                curve: Curves
                                    .bounceInOut,
                                child:
                                Container(
                                  width:
                                  300.0,
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
                                        SizedBox(width: 15,),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.network(
                                              valueOrDefault<String>(
                                                snapshot.data!['photo_url'],
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ruleta-izygr8/assets/gk8cg20c6m84/woman_avaatr.png',
                                              ),
                                              width: 60.0,
                                              height: 60.0,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                                          width: 200,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                child: Text(
                                                  snapshot.data!['display_name'],
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                child: Text(
                                                  snapshot.data!['email'],
                                                  maxLines: 1,
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
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: Text(winnerticket.toString(),style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900
                                ),),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: ()async{
                                  int participantlength = 0;
                                  int seeWinnerlength = 0;

                                  print("1");
                                  await widget.drawRef.get().then((value){
                                    Map data = value.data() as Map;
                                    seeWinnerlength = data['seeWinner'].length;
                                    participantlength = data['participants'].length;
                                  });
                                  print("2");

                                  if(snapshot.data!['uid'] == currentUserUid){
                                    currentUserReference!.update({
                                      'level': currentUserLevel+1,
                                    });
                                  }
                                  print("3");
                                  if(seeWinnerlength >= participantlength){
                                    await widget.drawRef.update({
                                      'status': false
                                    }).then((value){
                                      print("All participant have seen winner.");
                                      print("draw has been ended");
                                    });
                                  }
                                  print("4");
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> InicioWidget()), (route) => false);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Volver Home",style: TextStyle(
                                    color: Colors.white
                                  ),),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return Text("No Data");
                    },
                  ),

                ],
              )
          ],
        ),
    );
  }

  Future<Map<String, dynamic>> getParticipantData(
      DocumentReference docref) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, dynamic> userData = {};
    await firestore.collection("users").doc(docref.id).get().then((value) {
      if (value.data() != null) {
        userData = value.data()!;
      }
    });
    return userData;
  }

}
