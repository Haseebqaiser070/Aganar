import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sorteoaganar/auth/firebase_auth/auth_util.dart';
import 'package:sorteoaganar/flutter_flow/flutter_flow_theme.dart';
import 'package:sorteoaganar/user/Draw2Winner/Draw2Winner.dart';

import '../../admin/sorteo_backend/sorteo_handler.dart';
import '../../backend/push_notifications/push_notifications_util.dart';
import '../PrivateDrawWinner/PrivateDrawWinner.dart';


class PrivateDrawAllParticipant extends StatefulWidget {
  PrivateDrawAllParticipant({Key? key,required this.drawRef}) : super(key: key);
  DocumentReference drawRef;
  @override
  State<PrivateDrawAllParticipant> createState() => _PrivateDrawAllParticipantState();
}

class _PrivateDrawAllParticipantState extends State<PrivateDrawAllParticipant> {

  // Future<Map<String,dynamic>> getDraw()async{
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   Map<String,dynamic> drawData = {};
  //   await firestore.collection("Sorteo2").doc(widget.drawRef.id).get().then((value){
  //     if(value.data()!= null){
  //       drawData = value.data()!;
  //     }
  //   });
  //   return drawData;
  // }
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
          Text("Inicia el sorteo",style: FlutterFlowTheme.of(context).titleMedium,),
          SizedBox(height: 10,),
          CircleAvatar(backgroundImage: NetworkImage(currentUserPhoto),),
          SizedBox(height: 10,),
          Text(currentUserDisplayName,style: FlutterFlowTheme.of(context).titleSmall),
          SizedBox(height: 10,),
          Text("Participaras junto a todos ellos para llevarte el premio",style: FlutterFlowTheme.of(context).labelMedium),
          SizedBox(height: 50,),
          Expanded(
            child: FutureBuilder(
              future: getparticipant(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryBackground,),);
                }
                if(snapshot.connectionState == ConnectionState.done){
                  return GridView.count(
                    crossAxisCount: 3,
                    children: snapshot.data!.map((e){
                      return FutureBuilder(
                          future: getParticipantData(e),
                          builder: (context, userSnapshot){
                            if(userSnapshot.connectionState == ConnectionState.waiting){
                              return SizedBox();
                            }
                            if(userSnapshot.data == null){
                              return Text("notFound");
                            }
                            if(userSnapshot.connectionState == ConnectionState.done) {
                              Map user = userSnapshot.data!;
                              return Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(user['photo_url']??"https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(user['display_name']??"",style: FlutterFlowTheme.of(context).labelSmall,),
                                ],
                              );
                            }
                            return Text("notFound");
                          }
                      );
                    }).toList(),
                  );
                }
                return Center(child: Text("No Data"),);
              },
            ),
          ),
          InkWell(
            onTap: ()async{
              if(winnerRef != null){
                await widget.drawRef.update({
                  'seeWinner': FieldValue.arrayUnion([currentUserReference])
                });
                if(winnerRef == currentUserReference){
                  //send notification to winner
                  await sendNotification(
                      currentUserReference!,
                      "Eres ganadora",
                      "tu nivel es ahora.");
                  triggerPushNotification(
                    notificationTitle:
                    'Eres ganadora',
                    notificationText:
                    'tu nivel es ahora.',
                    notificationSound:
                    'default',
                    userRefs: [currentUserReference!],
                    initialPageName:
                    'notifications',
                    parameterData: {},
                  );
                  await currentUserReference!.update({
                    'level': currentUserLevel+1,
                  });
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivateDrawWinner(userRef: winnerRef!,drawRef: widget.drawRef,)));
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Ver ganadora"),
            ),
          )
        ],
      ),
    );
  }

  DocumentReference? winnerRef;

  Future<List<DocumentReference>> getparticipant()async{
    print("going...");
    List<DocumentReference> userRefList = [];
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    await widget.drawRef.get().then((value){
      Map drawdata = value.data() as Map;
      winnerRef = drawdata['winner'];
    });
    await widget.drawRef.collection("participant").get().then((value){
      for(QueryDocumentSnapshot q in value.docs){
        print(q.data());
        if(q.data() != null){
          Map qdata = q.data() as Map;
          userRefList.add(qdata['userRef']);
        }
      }
    });
    return userRefList;
  }

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
