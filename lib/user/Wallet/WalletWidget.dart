import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/firebase_auth/auth_util.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../inicio/inicio_widget.dart';

class WalletWidget extends StatefulWidget {
   WalletWidget({Key? key,required this.userRef}) : super(key: key);
  DocumentReference userRef;
  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  var items = [
    'Emoji ganador',
    'Cuenta regresive',
    'Elige tu numero de la suerte',
  ];

  String dorpDownValue = "Emoji ganador";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.arrow_back,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Wallet',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily:
                    FlutterFlowTheme.of(context).headlineMediumFamily,
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context)
                            .headlineMediumFamily),
                  ),
                ),
              ],
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(future: FirebaseFirestore.instance.collection("users").doc(widget.userRef.id).get(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: Text("Loading"),);
                }
                Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  decoration: BoxDecoration(
                      color: FlutterFlowTheme
                          .of(context)
                          .secondaryBackground,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 3,
                            offset: Offset(2,2),
                            blurRadius: 10
                        )
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Status: ${data['activo']?"Active":"InActive"}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: FlutterFlowTheme
                                .of(context)
                                .primary,
                            backgroundImage: NetworkImage(data['photo_url']??''),
                          ),
                          Expanded(child: Text(data['display_name']??'',textAlign: TextAlign.center,style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),)),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(data['email']??'',style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),),
                          ),
                          // Spacer(),
                          Expanded(
                            child: Text(data['phone_number']??'',style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 0, left: 10, right: 10, bottom: 0),
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
                        color: Colors.black
                    ),
                  ),
                ),
                DropdownButton(
                  value: dorpDownValue,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items,style: TextStyle(
                          color: Colors.black
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
                  iconEnabledColor: Colors.black,
                  underline: SizedBox(),
                ),
              ],
            ),
          ),
          Text("Mis transacciones",style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),

          if(dorpDownValue == "Emoji ganador")
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("payments").where('userRef', isEqualTo: widget.userRef).snapshots(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.connectionState == ConnectionState.none){
                  return Center(
                    child: Text("No payment Record."),
                  );
                }
                if(snapshot.data == null){
                  return Center(
                    child: Text("No payment Record."),
                  );
                }
                // List<Map<String,dynamic>> data = snapshot.data!.docs as List<Map<String,dynamic>>;
                return ListView(
                  physics: ClampingScrollPhysics(),
                  children: snapshot.data!.docs.map((e){
                    return FutureBuilder(future: FirebaseFirestore.instance.collection("sorteos").doc(e['ruffelRef'].id).get(),
                        builder: (context, sorteoData){
                      if(sorteoData.connectionState == ConnectionState.waiting){
                        return Center(child: Text("Loading"),);
                      }
                      if(sorteoData.data == null){
                        return SizedBox();
                      }
                      if(sorteoData.data!.data() == null){
                        return SizedBox();
                      }
                      Map<String,dynamic> sd = sorteoData.data!.data() as Map<String,dynamic>;
                          return ListTile(
                            leading:
                            sd['imagenRef'] == null || sd['imagenRef'] ==""?
                                SizedBox()
                                :
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(sd['imagenRef']),
                            ),
                            title: Text(sd['nombre_sorteo']),
                            subtitle: Text(e['isParticipate']?"Pay Participation Fee":"Win by Ruffle"),
                            trailing: e['isParticipate']?Text("-€${e['amount']}",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w900,
                              fontSize: 22
                            ),):Text("€+${e['amount']}",style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w900,
                                fontSize: 22
                            ),),
                          );
                        }
                    );
                  }).toList(),
                );
              },
            ),
          ),
          if(dorpDownValue == "Cuenta regresive")
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("payments").where('userRef', isEqualTo: widget.userRef).snapshots(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.none){
                    return Center(
                      child: Text("No payment Record."),
                    );
                  }
                  if(snapshot.data == null){
                    return Center(
                      child: Text("No payment Record."),
                    );
                  }
                  // List<Map<String,dynamic>> data = snapshot.data!.docs as List<Map<String,dynamic>>;
                  return ListView(
                    physics: ClampingScrollPhysics(),
                    children: snapshot.data!.docs.map((e){
                      return FutureBuilder(future: FirebaseFirestore.instance.collection("Sorteo2").doc(e['ruffelRef'].id).get(),
                          builder: (context, sorteoData){
                            if(sorteoData.connectionState == ConnectionState.waiting){
                              return Center(child: Text("Loading"),);
                            }
                            if(sorteoData.data == null){
                              return SizedBox();
                            }
                            if(sorteoData.data!.data() == null){
                              return SizedBox();
                            }
                            Map<String,dynamic> sd = sorteoData.data!.data() as Map<String,dynamic>;
                            return ListTile(
                              leading:
                              sd['image'] == null || sd['image'] ==""?
                              SizedBox()
                                  :
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(sd['image']),
                              ),
                              title: Text(sd['name']),
                              subtitle: Text(e['isParticipate']?"Pay Participation Fee":"Win by Ruffle"),
                              trailing: e['isParticipate']?Text("-€${e['amount']}",style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22
                              ),):Text("€+${e['amount']}",style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22
                              ),),
                            );
                          }
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          if(dorpDownValue == "Elige tu numero de la suerte")
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("payments").where('userRef', isEqualTo: widget.userRef).snapshots(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.none){
                    return Center(
                      child: Text("No payment Record."),
                    );
                  }
                  if(snapshot.data == null){
                    return Center(
                      child: Text("No payment Record."),
                    );
                  }
                  // List<Map<String,dynamic>> data = snapshot.data!.docs as List<Map<String,dynamic>>;
                  return ListView(
                    physics: ClampingScrollPhysics(),
                    children: snapshot.data!.docs.map((e){
                      return FutureBuilder(future: FirebaseFirestore.instance.collection("Sorteo3").doc(e['ruffelRef'].id).get(),
                          builder: (context, sorteoData){
                            if(sorteoData.connectionState == ConnectionState.waiting){
                              return Center(child: Text("Loading"),);
                            }
                            if(sorteoData.data == null){
                              return SizedBox();
                            }
                            if(sorteoData.data!.data() == null){
                              return SizedBox();
                            }
                            Map<String,dynamic> sd = sorteoData.data!.data() as Map<String,dynamic>;
                            return ListTile(
                              leading:
                              sd['image'] == null || sd['image'] ==""?
                              SizedBox()
                                  :
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(sd['image']),
                              ),
                              title: Text(sd['name']),
                              subtitle: Text(e['isParticipate']?"Pay Participation Fee":"Win by Ruffle"),
                              trailing: e['isParticipate']?Text("-€${e['amount']}",style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22
                              ),):Text("€+${e['amount']}",style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22
                              ),),
                            );
                          }
                      );
                    }).toList(),
                  );
                },
              ),
            )
        ],
      ),
    );
  }


  Future<String> getSorteoName(DocumentReference reference)async{
    String sorteoName = "";
    FirebaseFirestore.instance.collection("sorteos").doc(reference.id).get().then((value){
      if(value.data() != null)
      sorteoName =  value.data()!['nombre_sorteo'];
    }).catchError((e){
      print("eeror $e");
    });

    return sorteoName;
  }
}
