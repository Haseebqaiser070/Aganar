import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sorteoaganar/index.dart';
import '../../admin/sorteo_backend/sorteo_handler.dart';
import '../../auth/firebase_auth/auth_util.dart';
import '../../backend/push_notifications/push_notifications_util.dart';
import '../../backend/stripe/payment_manager.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class ShowTicketList4 extends StatefulWidget {
  ShowTicketList4({Key? key,required this.sorteo}) : super(key: key);
  Map<String,dynamic> sorteo;
  @override
  State<ShowTicketList4> createState() => _ShowTicketList4State();
}

class _ShowTicketList4State extends State<ShowTicketList4> {
  List<int> selectedTicketList = [];
  List<int> ticketList = [];
  int ticketLimite = 0;
  // List<int> ticketList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 1; i <= 10000; i++) {
      ticketList.add(i);
    }
    selectunsoldTicket();
    ticketLimite = widget.sorteo['ticketLimite'];
  }

  selectunsoldTicket(){
    List soldTickets = widget.sorteo['soldTickets']??[];
    for(int ticket in soldTickets){
      if(ticketList.contains(ticket)){
        ticketList.removeWhere((element) => element == ticket);
      }
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      ),
      body: Column(
        children: [
          Expanded(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: GridView.count(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 5,
              children: ticketList.map((e){
                return ticketButton(e, (){
                  if(selectedTicketList.contains(e)){
                    selectedTicketList.removeWhere((element) => element == e);
                  }
                  else if(selectedTicketList.length < ticketLimite){
                    selectedTicketList.add(e);
                  }
                  setState(() {
                    print(selectedTicketList);
                  });
                });
              }).toList(),
            ),
          )),
          InkWell(
            onTap: ()async{

              await currentUserReference!.update({
                'Sorteo4': FieldValue.arrayUnion([widget.sorteo['ref']]),
              });

              jointDraw4(widget.sorteo['ref'], selectedTicketList);

            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text("seleccionar",style: TextStyle(
                color: FlutterFlowTheme.of(context).accent3,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
            ),
          )
        ],
      ),
    );
  }



  Widget ticketButton(int ticketNumber, Function() fnc){
    return InkWell(
      onTap: fnc,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: selectedTicketList.contains(ticketNumber)? FlutterFlowTheme.of(
                context)
                .primaryBackground:FlutterFlowTheme.of(
                context)
                .secondaryBackground,
            boxShadow: [
              BoxShadow(color: Colors.white12,offset: Offset(2,2), blurRadius: 5,spreadRadius: 4)
            ]
        ),
        alignment: Alignment.center,
        child: Text(ticketNumber.toString(),style: TextStyle(
            color: Colors.white
        ),),
      ),
    );
  }



  Future jointDraw4(DocumentReference drawRef, List tickets)async{
    DocumentReference doc = drawRef.collection("participant").doc();
    await doc.set({
      'userRef': currentUserReference,
      'uid': doc.id,
      'tickets': tickets,
    }).then((value){
      Fluttertoast.showToast(msg: "Eres participante de este sorteo ahora.");
    });
    await drawRef.update({
      'participants': FieldValue.arrayUnion([currentUserReference]),
      'soldTickets': FieldValue.arrayUnion(tickets),
    });

    int limite = 0;
    int participant = 0;
    List participantsList = [];
    await drawRef.get().then((value){
      Map<String,dynamic> data = value.data() as Map<String,dynamic>;
      limite = data['limite'];
      participantsList = data['participants'];
    });
    await drawRef.collection("participant").get().then((value){
      participant = value.docs.length;
    });

    if(participant >= limite){
      DateTime endtime = DateTime.now();
      await drawRef.update({
        'timer': true,
        'endTime': endtime,
      });


      List<DocumentReference> docrefobj = [];
      for(DocumentReference ref in participantsList){
        // await sendNotification(ref, "Timer has started", "Winner will announce in 3 minutes.");
        docrefobj.add(ref);
      }


      sendToAllNotification(docrefobj,"El cronómetro ha comenzado", "El ganador se anunciará en 3 minutos.");

      triggerPushNotification(
        notificationTitle:
        'El cronómetro ha comenzado',
        notificationText:
        'El ganador se anunciará en 3 minutos.',
        notificationSound:
        'default',
        userRefs: docrefobj,
        initialPageName:
        'notifications',
        parameterData: {},
      );
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> InicioWidget()), (route) => false);

  }

}
