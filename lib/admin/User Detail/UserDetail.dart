import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../user/Wallet/WalletWidget.dart';


class UserDetail extends StatefulWidget {
  UserDetail({Key? key,required this.userRef}) : super(key: key);
  DocumentReference userRef;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTotalDrawCount();
  }

  RxInt level = 0.obs;

  Future<Map<dynamic,dynamic>> getUserData()async{
    Map<dynamic,dynamic> data = {};
    await widget.userRef.get().then((value){
      // print(value.data());
      data =  value.data() as Map<dynamic,dynamic>;
    });
    return data;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<int> getwinDrawCount()async{
    int draw1Count = 0;
    int draw2Count = 0;
    int draw3Count = 0;
    int draw4Count = 0;
    int count = 0;
    await firestore.collection("sorteos").where("ganador", isEqualTo: widget.userRef).get().then((value){
      draw1Count = value.docs.length;
    });
    await firestore.collection("Sorteo2").where("winner", isEqualTo: widget.userRef).get().then((value){
      draw2Count = value.docs.length;
    });
    await firestore.collection("Sorteo3").where("winner", isEqualTo: widget.userRef).get().then((value){
      draw3Count = value.docs.length;
    });
    await firestore.collection("Sorteo4").where("winner", isEqualTo: widget.userRef).get().then((value){
      draw4Count = value.docs.length;
    });
    count = draw1Count + draw2Count + draw3Count + draw4Count;
    print("total win");
    print(count);

      level.value = count;

    return count;
  }

  Future<int> getTotalDrawCount()async{
    int count = 0;
    await widget.userRef.get().then((value)async{
      // print(value.data());
      final data =  value.data() as Map<dynamic,dynamic>;
      final int draw1count = data['mis_sorteos'].length;
      final int draw2count = data['Sorteo2'].length;
      final int draw3count = data['Sorteo3'].length;
      final int draw4count = data['Sorteo4'].length;
      count = draw1count + draw2count + draw3count + draw4count;
      print("total count");
      print(count);
    });

    return count;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Color(0x007237ED),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).grayIcon,
            size: 30.0,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 0.0, 0.0),
          child: Text(
            'Usuario',
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: Text("Loading"),);
          }
          if(snapshot.connectionState == ConnectionState.none){
            return Center(child: Text("Cannot Load Data"),);
          }
          if(snapshot.data == null){
            return Center(child: Text("Cannot Load Data"),);
          }
          Map user = snapshot.data!;
          print(user);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(user['photo_url']??'',fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: Text('Image not available!'),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Estado del perfil:",style: FlutterFlowTheme.of(context).titleSmall,),
                          SizedBox(width: 5,),
                          Text(user['activo']?"Active":"Inactive",style: FlutterFlowTheme.of(context).titleSmall),
                        ],
                      ),
                      Text(user['display_name']??"",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                      ),),
                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.admin_panel_settings_rounded,size: 30,color: FlutterFlowTheme.of(context).secondaryBackground,),
                              Text("Nivel",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                              ),),
                            ],
                          ),
                          Obx(() => Text("${level.value}",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),),),
                          // Text(user['level'] == null?"0":user['level'].toString(),style: TextStyle(
                          //   fontSize: 18,
                          //   fontWeight: FontWeight.w700,
                          //   color: Colors.green,
                          // ),),
                        ],
                      ),

                      SizedBox(height: 40,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          boxShadow: [
                            BoxShadow(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              // color: Color.fromARGB(100, 229, 227, 227),
                              blurRadius: 5,
                              spreadRadius: 5,
                              offset: Offset(2,2)
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text("Detalle del sorteo",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                            ),),
                            SizedBox(height: 20,),
                            FutureBuilder(
                                future: getwinDrawCount(),
                                builder: (context,winsnapshot){
                                  if(winsnapshot.connectionState == ConnectionState.done){

                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.keyboard_double_arrow_up_sharp,color: Colors.green,size: 40,),
                                            Column(
                                              children: [
                                                Text("Ganar",style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                                Text(winsnapshot.data.toString(),style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),)
                                              ],
                                            ),
                                          ],
                                        ),
                                        FutureBuilder(future: getTotalDrawCount(),
                                            builder: (context, totalSnapshot){
                                              if(totalSnapshot.connectionState == ConnectionState.done){
                                                int count = totalSnapshot.data == null?0:totalSnapshot.data!-winsnapshot.data!;
                                                return Row(
                                                  children: [
                                                    Icon(Icons.keyboard_double_arrow_down_sharp,color: Colors.redAccent,size: 40,),
                                                    Column(
                                                      children: [
                                                        Text("Perder",style: TextStyle(
                                                          color: Colors.redAccent,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                        Text(count.toString(),style: TextStyle(
                                                          color: Colors.redAccent,
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.bold,
                                                        ),)
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }
                                              return SizedBox();
                                            }
                                        ),

                                      ],
                                    );
                                  }
                                  return SizedBox();
                                }
                            ),
                            SizedBox(height: 20,),
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WalletWidget(userRef: widget.userRef,),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text("View Detail",style: TextStyle(
                                    color: Colors.white
                                ),),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
