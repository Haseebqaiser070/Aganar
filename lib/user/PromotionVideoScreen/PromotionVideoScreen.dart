import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sorteoaganar/flutter_flow/flutter_flow_theme.dart';
import 'package:sorteoaganar/user/SingleVideoScreen/SingleVideoScreen.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class PromotionVideoScreen extends StatefulWidget {
  const PromotionVideoScreen({Key? key}) : super(key: key);

  @override
  State<PromotionVideoScreen> createState() => _PromotionVideoScreenState();
}

class _PromotionVideoScreenState extends State<PromotionVideoScreen> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFunc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? docId;
  Future initFunc() async {
    await firestore.collection("DB_negocio").get().then((value) {
      docId = value.docs[0].id;
    });

    setState(() {});
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
        title: Text(
          'vídeos de aplicaciones',
          style: FlutterFlowTheme.of(context).titleLarge,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          setState(() {

          });
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("DB_negocio")
                        .doc(docId).collection("Videos")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text(
                            "Loading",
                            style: TextStyle(
                                color: FlutterFlowTheme.of(context).accent3),
                          ),
                        );
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text(
                            "No Video",
                            style: TextStyle(
                                color: FlutterFlowTheme.of(context).accent3),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.active) {
                        if(snapshot.data!.docs.length == 0){
                          return Center(
                            child: Text("No Video is Uploaded.",style: TextStyle(
                              color: FlutterFlowTheme.of(context).accent3,
                            ),),
                          );
                        }
                        return GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          padding: EdgeInsets.symmetric(vertical: 30),
                          children: snapshot.data!.docs.map((e) {
                            Map<String,dynamic> data = e.data();
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SingleVideoScreen(url: data['video'])));
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(data['thumbnail'],fit: BoxFit.cover,width: double.infinity,height: double.infinity,)),
                                  Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SingleVideoScreen(url: data['video'])));
                                      },
                                      icon: Icon(Icons.play_circle,color: FlutterFlowTheme.of(context).secondaryBackground,size: 35,),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return Center(
                        child: Text(
                          "No Video",
                          style:
                          TextStyle(color: FlutterFlowTheme.of(context).accent3),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
