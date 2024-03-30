import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';

import '../../backend/schema/notificaciones_record.dart';
import '../../backend/schema/sorteos_record.dart';
import '../../flutter_flow/flutter_flow_util.dart';


Future createSorteoStream(DocumentReference reference)async{
  print("createSorteoStream");
  Stream<DocumentSnapshot<Map<String, dynamic>>> sorteoStream = FirebaseFirestore.instance.collection('sorteos').doc(reference.id).snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> sorteoParticipantStream = FirebaseFirestore.instance.collection('sorteos').doc(reference.id).collection("selectedTickets").snapshots();

  sorteoStream.listen((event) {
    print("sorteolisten");
    print(event.data()!['limite_participantes']);
  });


  sorteoParticipantStream.listen((event) async{
    print("sorteoparticipantlisten");
    print(event.docs.length);
    int participantLength = event.docs.length;
    int sorteoLimite = await getsortioLimiteCount(reference);
    bool timer = await getsortiotimerValue(reference);
    bool drawstatus = await getsortiostatusValue(reference);


    if(participantLength >= sorteoLimite && timer == false && drawstatus == true){


      List<DocumentReference> participantList = [];

      for(int i=0; i<participantLength; i++){
        participantList.add(event.docs[i].data()['usuario']);
      }
      
      await sendToAllNotification(participantList, "el sorteo está listo", "Articularse para ver resultados");
      
      
      print("Sorteoisfull");
      await startTimer(reference);

      // Choose random number
      int winnerNumber = math.Random().nextInt(event.docs.length);
      print("winner is:");
      print(winnerNumber);
      print(event.docs[winnerNumber].data()['usuario']);
      DocumentReference winnerRef = event.docs[winnerNumber].data()['usuario'];


      await reference.update({
        'ganador': winnerRef,
        // 'timer': false,
      });

      // await sendNotification(winnerRef,"Eres ganadora","Felicidades, eres ganadora.");


      await Future.delayed(Duration(seconds: 1));


      

      await  reference.update({
        'jugoSorteo': participantList,
      });


      await Future.delayed(Duration(seconds: 120));
      await reference.update({
        'estado_sorteo': false,
        // 'timer': false,
      });

    }


  });

}


Future startTimer(DocumentReference documentReference)async{
  print("Timer starting+++");

  // var sorteosRecordReference =
  // SorteosRecord.collection.doc();
  await documentReference
      .update({
    'estado_sorteo': true,
    'timer': true
  });

  for(int minute=2; minute>=0; minute--){
    for(int i=20; i>=0; i--){

      String mnt = NumberFormat("00").format(minute);
      String scd = NumberFormat("00").format(i);


      await documentReference
          .update(createSorteoTimeData(
        minute: mnt,
        second: scd,
      ));

      // await documentReference
      //     .update(createSorteoTimeData(
      //   minute: minute,
      //   second: i,
      // ));
      print("$mnt: $scd");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  print("now going endeing");
  await documentReference
      .update({
    'estado_sorteo': true,
    // 'timer': false,
  });
}


Future<int> getsortioLimiteCount(DocumentReference reference)async{
  return FirebaseFirestore.instance.collection('sorteos').doc(reference.id).get().then((value) => value.data()!['limite_participantes']);
}


Future<bool> getsortiotimerValue(DocumentReference reference)async{
  return FirebaseFirestore.instance.collection('sorteos').doc(reference.id).get().then((value) => value.data()!['timer']);
}
Future<bool> getsortiostatusValue(DocumentReference reference)async{
  return FirebaseFirestore.instance.collection('sorteos').doc(reference.id).get().then((value) => value.data()!['estado_sorteo']);
}

Future sendNotification(DocumentReference reference, String title, String content)async{

  print("sendNotification*");

  // List<DocumentReference> userRefList = [];
  //
  // for(SelectedTicketsRecord s in snapshot){
  //   userRefList.add(s.usuario!);
  // }



  var notificacionesRecordReference =
  NotificacionesRecord
      .collection
      .doc();
  await notificacionesRecordReference
      .set({
    ...createNotificacionesRecordData(
      titulo:
      title,
      contenido:
      content,
      createdDate:
      getCurrentTimestamp,
      isCashPayment:
      false,
      requiredParameter:
      reference,
    ),
    'notifiedUsersList':
    [reference],
  });

  // NotificacionesRecord
  //     .getDocumentFromData({
  //   ...createNotificacionesRecordData(
  //     titulo:
  //     'Elige Tu Emoji++++',
  //     contenido:
  //     'Por favor, elige tu emoji para el sorte++++++++',
  //     createdDate:
  //     getCurrentTimestamp,
  //     isCashPayment:
  //     true,
  //     requiredParameter:
  //     snapshot[0].reference,
  //   ),
  //   'notifiedUsersList':
  //   userRefList,
  // }, notificacionesRecordReference);
  //
  //
  //
  //
  //
  // triggerPushNotification(
  //   notificationTitle:
  //   'Empieza Sorteo***',
  //   notificationText:
  //   'El sorteo******',
  //   notificationSound:
  //   'default',
  //   userRefs:userRefList,
  //   initialPageName:
  //   'successImage',
  //   parameterData: {
  //     'numberSorteo':
  //     snapshot[0].parentReference,
  //   },
  // );
}


Future sendToAllNotification(List<DocumentReference> reference, String title, String content)async{

  print("sendNotificationTo All*");

  // List<DocumentReference> userRefList = [];
  //
  // for(SelectedTicketsRecord s in snapshot){
  //   userRefList.add(s.usuario!);
  // }


  var notificacionesRecordReference =
  NotificacionesRecord
      .collection
      .doc();
  await notificacionesRecordReference
      .set({
    ...createNotificacionesRecordData(
      titulo:
      title,
      contenido:
      content,
      createdDate:
      getCurrentTimestamp,
      isCashPayment:
      false,
      // requiredParameter:
      // reference,
    ),
    'notifiedUsersList':
    reference,
  });

  // NotificacionesRecord
  //     .getDocumentFromData({
  //   ...createNotificacionesRecordData(
  //     titulo:
  //     'Elige Tu Emoji++++',
  //     contenido:
  //     'Por favor, elige tu emoji para el sorte++++++++',
  //     createdDate:
  //     getCurrentTimestamp,
  //     isCashPayment:
  //     true,
  //     requiredParameter:
  //     snapshot[0].reference,
  //   ),
  //   'notifiedUsersList':
  //   userRefList,
  // }, notificacionesRecordReference);
  //
  //
  //
  //
  //
  // triggerPushNotification(
  //   notificationTitle:
  //   'Empieza Sorteo***',
  //   notificationText:
  //   'El sorteo******',
  //   notificationSound:
  //   'default',
  //   userRefs:userRefList,
  //   initialPageName:
  //   'successImage',
  //   parameterData: {
  //     'numberSorteo':
  //     snapshot[0].parentReference,
  //   },
  // );
}

// getActiveSorteo()async{
//   Stream<List<SorteosRecord>>  giveawaysStream = querySorteosRecord(
//     queryBuilder: (sorteosRecord) =>
//         sorteosRecord.where("estado_sorteo", isEqualTo: true),
//   );
//
//   giveawaysStream.listen((List<SorteosRecord> snapshot) async{
//     for(SorteosRecord s in snapshot){
//       print("sorteo edited");
//       print(s.limiteParticipantes);
//       await getparticipant(s.reference,s.limiteParticipantes,s.uid);
//     }
//   });
// }
// Future getparticipant(DocumentReference reference,int sortioLimite,String sorteoId)async{
//   Stream<List<SelectedTicketsRecord>>  giveawaysStream = querySelectedTicketsRecord(
//     parent: reference,
//   );
//
//
//
//
//   giveawaysStream.listen((List<SelectedTicketsRecord> snapshot) async{
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     print("*");
//     if(snapshot.length>= sortioLimite){
//
//       await startTimer(reference);
//
//       // if(prefs.getString("isSend") != sorteoId && prefs.getString("isSend") != ""){
//       //   print(prefs.getString("isSend"));
//       //   print("original $sorteoId");
//       //   prefs.setString("isSend", sorteoId);
//       //   // await sendNotification(snapshot);
//       //   await startTimer(reference);
//       //
//       // }
//     }
//   });
//
// }



// Future startFect()async{
//   DateTime currentTime = DateTime.now();
//   DateTime futueTime = DateTime.now();
//
//    final remainingTime = futueTime.difference(currentTime);
//    print(remainingTime);
// }


Stream SorteoStream()async*{
    FirebaseFirestore.instance.collection('sorteos').where('timer', isEqualTo: true).where('estado_sorteo',isEqualTo: true).snapshots();
}


Future listenSorteoStream()async{

}




// class TimerHandle extends ChangeNotifier{
//
//   int hours = 00;
//   int minutes = 00;
//   int seconds = 00;
//
//   void handleTimer( DateTime givenDateTime){
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       final currentDateTime = DateTime.now();
//       if (currentDateTime.isBefore(givenDateTime)) {
//         final difference = givenDateTime.difference(currentDateTime);
//         print('Time left: ${difference.inHours}:${difference.inMinutes % 60}:${difference.inSeconds % 60}');
//         hours = difference.inHours;
//         minutes = difference.inMinutes;
//         seconds = difference.inSeconds;
//         notifyListeners();
//       } else {
//         timer.cancel();
//         print('Timer expired.');
//       }
//     });
//   }
// }