

// const admin = require('firebase-admin');
// admin.initializeApp();
// const functions = require('firebase-functions');


// exports.scheduledScrapperFunction = functions
//   .runWith({ memory: "1GB" })
//   .pubsub.schedule("every 1 minutes")
//   .onRun(async (context) => {
//     console.log(`Documents starting reading....`);

//     const drawSnapshot = await admin.firestore().collection('Sorteo2').where("status", "==", true).get();
//     const currentTimestamp = admin.firestore.FieldValue.serverTimestamp();
//     const batch = admin.firestore().batch();

//     drawSnapshot.forEach(async (doc) => {
//       console.log(`Document: ${doc.data().name}, ${doc.data().status} ${doc.data().endTime.toDate()}`);
//       console.log(doc.data().endTime.toDate());
//       console.log(new Date());

//       try {
//         if (new Date().getTime() >= doc.data().endTime.toDate().getTime()){
//           const docRef = admin.firestore().collection('Sorteo2').doc(doc.id); // Get a reference to the document
//           batch.update(docRef, { timer: true });
//           console.log(`Document ${doc.id} updated successfully.`);
//         }
//       } catch (error) {
//         console.error(`Error document ${doc.id}: ${error}`);
//       }
//     });

//     await batch.commit();

//   });



const admin = require('firebase-admin');
admin.initializeApp();
const functions = require('firebase-functions');


exports.scheduledScrapperFunction = functions
  .runWith({ memory: "1GB" })
  .pubsub.schedule("every 1 minutes")
  .onRun(async (context) => {
    console.log(`Documents starting reading....`);

    const drawSnapshot = await admin.firestore().collection('Sorteo2').where("status", "==", true).get();
    const currentTimestamp = admin.firestore.FieldValue.serverTimestamp();
    const batch = admin.firestore().batch();

    drawSnapshot.forEach(async (doc) => {
      try {
        if (new Date().getTime() >= doc.data().endTime.toDate().getTime() && doc.data().timer == false) {
          const docRef = admin.firestore().collection('Sorteo2').doc(doc.id); // Get a reference to the document
          batch.update(docRef, { timer: true });
          console.log(`Document ${doc.id} updated successfully.`);
      

          // send notification to all users.
          

            //getting participant doc ref
          const participantSnapshot = await admin.firestore().collection('Sorteo2').doc(doc.id).collection('participant').get();
          const usersRefList = [];
          
          participantSnapshot.forEach(async (participant) => {
            usersRefList.push(participant.data().userRef);
          });

            await admin.firestore().collection('notificaciones').doc().set(
              {
                'titulo': "Draw started",
                'contenido': "Winner will announce in 3 minutes.",
                'created_date': admin.firestore.FieldValue.serverTimestamp(),
                'isCashPayment': false,
                'notifiedUsersList': usersRefList,
              }
            );

            usersRefList.forEach(async (element) => {
              await admin.firestore().collection('ff_user_push_notifications').doc().set(
                {
                  'initial_page_name': "notifications",
                  'notification_sound': "default",
                  'notification_title': "Draw started.",
                  'notification_text': "Winner will announce in 3 minutes.",
                  'num_sent': 9,
                  'parameter_data': "{}",
                  'sender': element,
                  'status': "succeeded",
                  'timestamp':currentTimestamp,
                  'user_refs': element.path,
                }
              );
              console.log(element);
            });


            console.log("notification sended");
        }
      } catch (error) {
        console.error(`Error document ${doc.id}: ${error}`);
      }
    });

    await batch.commit();

  });