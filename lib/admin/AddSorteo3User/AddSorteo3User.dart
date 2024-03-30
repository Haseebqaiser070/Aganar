import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sorteoaganar/admin/sorteo_backend/sorteo_handler.dart';
import 'package:sorteoaganar/index.dart';
import '../../backend/push_notifications/push_notifications_util.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class AddSorteo3User extends StatefulWidget {
  AddSorteo3User({Key? key,required this.sorteo,required this.userRef}) : super(key: key);
  Map<String,dynamic> sorteo;
  DocumentReference userRef;
  @override
  State<AddSorteo3User> createState() => _AddSorteo3UserState();
}

class _AddSorteo3UserState extends State<AddSorteo3User> {
  List<int> selectedTicketList = [];
  List<int> ticketList = [];
  // List<int> ticketList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 1; i <= 10000; i++) {
      ticketList.add(i);
    }
    selectunsoldTicket();
  }

  selectunsoldTicket(){
    List soldTickets = widget.sorteo['soldTickets'];
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
                  else{
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
              int totalAmount = widget.sorteo['value'] * selectedTicketList.length;
              print(totalAmount);
              await widget.userRef.update({
                'Sorteo3': FieldValue.arrayUnion([widget.sorteo['ref']]),
              });
              await storePayment(widget.userRef, widget.sorteo['ref'], totalAmount, true);
              saveParticipant(totalAmount,selectedTicketList);
              sendNotification(widget.userRef, "You are added.", "${widget.sorteo['name']} will end on time.");
              triggerPushNotification(
                notificationTitle:
                'You are added.',
                notificationText:
                '${widget.sorteo['name']} will end on time.',
                notificationSound:
                'default',
                userRefs: [widget.userRef],
                initialPageName:
                'notifications',
                parameterData: {},
              );
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
              child: Text("Seleccionar",style: TextStyle(
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


  Future saveParticipant(int amount,List tickets)async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // List totalSoldTickets = widget.sorteo['soldTickets'] + tickets;
    await firestore.collection("Sorteo3").doc(widget.sorteo['uid']).update({
      'soldTickets': FieldValue.arrayUnion(tickets),
      'participants': FieldValue.arrayUnion([widget.userRef]),
    });
    DocumentReference documentReference =  firestore.collection("Sorteo3").doc(widget.sorteo['uid']).collection("participant").doc();
    await documentReference.set({
      'userRef': widget.userRef,
      'amount':  amount,
      'tickets': tickets,
      'uid': documentReference.id,
    }).then((value){
      Fluttertoast.showToast(msg: "Eres participante de este sorteo ahora.");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> InicioWidget()), (route) => false);
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
}
