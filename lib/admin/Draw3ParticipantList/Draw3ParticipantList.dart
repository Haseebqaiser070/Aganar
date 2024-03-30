import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sorteoaganar/auth/firebase_auth/auth_util.dart';
import 'package:sorteoaganar/flutter_flow/flutter_flow_theme.dart';
import 'package:sorteoaganar/user/Draw2Winner/Draw2Winner.dart';

import '../../admin/sorteo_backend/sorteo_handler.dart';
import '../../backend/push_notifications/push_notifications_util.dart';
import '../../user/inicio/inicio_widget.dart';


class Draw3ParticipantList extends StatefulWidget {
  Draw3ParticipantList({Key? key,required this.drawRef}) : super(key: key);
  DocumentReference drawRef;
  @override
  State<Draw3ParticipantList> createState() => _Draw3ParticipantListState();
}

class _Draw3ParticipantListState extends State<Draw3ParticipantList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text("Toda la lista de participantes y sus entradas.",style: FlutterFlowTheme.of(context).titleSmall),
          SizedBox(height: 50,),
          Expanded(
            child: StreamBuilder(
              stream: widget.drawRef.collection("participant").snapshots(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: Text("Loading"),);
                }
                if(snapshot.connectionState == ConnectionState.active){

                  return ListView(
                    children: snapshot.data!.docs.map((e){
                      Map participant = e.data();
                      List tickets = participant['tickets'];
                      return FutureBuilder(future: getParticipantData(participant['userRef']), 
                          builder: (context, userSnap){
                            if(userSnap.connectionState == ConnectionState.waiting){
                              return Center(child: Text("Loading"),);
                            }
                            if(userSnap.connectionState == ConnectionState.done){
                              Map user = userSnap.data!;
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  borderRadius: BorderRadius.circular(10),
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
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if(user['photo_url'] != null)
                                        SizedBox(height: 79,width: 100,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(user['photo_url'],fit: BoxFit.cover,)),
                                        ),
                                        SizedBox(width: 5,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5,),
                                              Text(user['display_name'],style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).accent3,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),),
                                              SizedBox(height: 5,),
                                              Text(user['email'],style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).accent3,
                                                  fontSize: 16,
                                              ),),
                                              SizedBox(height: 5,),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.end,
                                              //   children: [
                                              //     InkWell(
                                              //       onTap:()async{
                                              //         bool winner = false;
                                              //         await widget.drawRef.get().then((value){
                                              //           Map draw = value.data() as Map;
                                              //           if(draw['winner'] == null){
                                              //             winner = false;
                                              //           }
                                              //           else{
                                              //             winner = true;
                                              //           }
                                              //         });
                                              //         if(winner == false){
                                              //           await widget.drawRef.update({
                                              //             'winner': participant['userRef'],
                                              //           }).then((value){
                                              //             print("winner selected");
                                              //             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> InicioWidget()), (route) => false);
                                              //           });
                                              //         }else{
                                              //           Fluttertoast.showToast(msg: "winner has announced");
                                              //         }
                                              //
                                              //       },
                                              //       child: Container(
                                              //         decoration: BoxDecoration(
                                              //           borderRadius: BorderRadius.circular(10),
                                              //           color: FlutterFlowTheme.of(context).primaryBackground
                                              //         ),
                                              //         padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                              //         margin: EdgeInsets.symmetric(horizontal: 10,),
                                              //         alignment: Alignment.center,
                                              //         child: Text("Select Winner",style: TextStyle(
                                              //           color: Colors.white
                                              //         ),),
                                              //       ),
                                              //     )
                                              //   ],
                                              // )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 3,),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).accent3,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      height: 130,
                                      child: GridView.count(
                                        crossAxisCount: 5,
                                        children: tickets.map((e){
                                          return InkWell(
                                            onTap:()async{
                                              showDialog(context: context, builder: (context) => AlertDialog(
                                                title: Text("Seleccionas ganador $e"),
                                                actions: [
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>( FlutterFlowTheme.of(context).secondaryBackground)
                                                    ),
                                                      onPressed: ()async{
                                                    Navigator.pop(context);

                                                  }, child: Text("Cancel")),
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>( FlutterFlowTheme.of(context).secondaryBackground)
                                                      ),
                                                      onPressed: ()async{
                                                    bool winner = false;
                                                    await widget.drawRef.get().then((value){
                                                      Map draw = value.data() as Map;
                                                      if(draw['winner'] == null){
                                                        winner = false;
                                                      }
                                                      else{
                                                        winner = true;
                                                      }
                                                    });
                                                    if(winner == false){
                                                      await widget.drawRef.update({
                                                        'winner': participant['userRef'],
                                                        'WinnerTicket': e,
                                                      }).then((value){
                                                        print("winner selected");
                                                        sendNotification(participant['userRef'], "Felicidades","tu ganas el sorteo");
                                                        triggerPushNotification(
                                                          notificationTitle:
                                                          'Felicidades',
                                                          notificationText:
                                                          'Tu ganas el sorteo.',
                                                          notificationSound:
                                                          'default',
                                                          userRefs: [participant['userRef']],
                                                          initialPageName:
                                                          'notifications',
                                                          parameterData: {},
                                                        );
                                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> InicioWidget()), (route) => false);
                                                      });
                                                    }else{
                                                      Fluttertoast.showToast(msg: "La ganadora ha anunciado");
                                                    }

                                                  }, child: Text("Ok")),
                                                ],
                                              ));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: FlutterFlowTheme.of(context).secondaryBackground
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(e.toString()),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return SizedBox();
                          }
                      );
                    }).toList(),
                  );
                }
                return Center(child: Text("No participant"),);
              },
            ),
          ),
        ],
      ),
    );
  }


  // Future<List<DocumentReference>> getparticipant()async{
  //   print("going...");
  //   List<DocumentReference> userRefList = [];
  //   // FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   await widget.drawRef.get().then((value){
  //     Map drawdata = value.data() as Map;
  //   });
  //   await widget.drawRef.collection("participant").get().then((value){
  //     for(QueryDocumentSnapshot q in value.docs){
  //       print(q.data());
  //       if(q.data() != null){
  //         Map qdata = q.data() as Map;
  //         userRefList.add(qdata['userRef']);
  //       }
  //     }
  //   });
  //   return userRefList;
  // }

  Future<Map<String,dynamic>> getParticipantData(DocumentReference docref)async{
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
