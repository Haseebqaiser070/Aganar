import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sorteoaganar/flutter_flow/flutter_flow_theme.dart';
import 'package:sorteoaganar/user/SingleVideoScreen/SingleVideoScreen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../auth/firebase_auth/auth_util.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class uploadVideo extends StatefulWidget {
  const uploadVideo({Key? key}) : super(key: key);

  @override
  State<uploadVideo> createState() => _uploadVideoState();
}

class _uploadVideoState extends State<uploadVideo> {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).grayIcon),
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (valueOrDefault<bool>(currentUserDocument?.isAdmin, false))
                  AuthUserStreamWidget(
                    builder: (context) => FlutterFlowIconButton(
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
                  ),
                Text(
                  'Promotion Video',
                  style: FlutterFlowTheme.of(context).titleLarge,
                ),
              ],
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
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
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: (){
                                        deleteVideo(data["uid"], data['video'], data['thumbnail']);
                                        
                                      },
                                      icon: Icon(Icons.delete,color: FlutterFlowTheme.of(context).secondaryBackground,size: 25,),
                                    ),
                                  )
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
              InkWell(
                onTap: () => {uploadVideo()},
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 249, 43, 249),
                            blurRadius: 10,
                            spreadRadius: 5)
                      ],
                      border: Border.all(color: Colors.white, width: 2)),
                  child: Text(
                    isLoading
                        ? "Uploading...."
                        : "Upload Video",
                    style: TextStyle(
                        color: FlutterFlowTheme.of(context).accent3,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future uploadVideo() async {
    try {
      setState(() {
        isLoading = true;
      });
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      if (result != null) {
        File videoFile = File(result.files.single.path!);
        String videoFileName = path.basename(videoFile.path);


        // check if video already uploaded or not
          QuerySnapshot<Map> videosQuerySnapshot = await firestore.collection(
              "DB_negocio").doc(docId).collection("Videos").get();
          if(videosQuerySnapshot.docs.length != 0){
            print(videosQuerySnapshot.docs.length);
            for(final e in videosQuerySnapshot.docs){
              if(e.data().isNotEmpty){
                Map docData = e.data();
                String? link = docData["video"];
                if(link != null){
                  print(link);
                  Uri uri = Uri.parse(link);
                  String fileRoute = uri.pathSegments.last;
                  List splitList = fileRoute.split("/");
                  String uploadFileName = splitList.last;
                  print(uploadFileName);
                  print(videoFileName);
                  if(videoFileName == uploadFileName){
                    Fluttertoast.showToast(msg: "Vídeo ya subido");
                    setState(() {
                      isLoading = false;
                    });
                    return;

                  }
                }
              }
            }
          }





        // check video size
        int fileSize = await videoFile.length();
        // if (fileSize < 32000000 && fileSize > 5000000) {
        if (fileSize < 55000000 && fileSize > 2000000) {
          // upload new video
          final videoRef =
          firebaseStorage.ref().child("users/$currentUserUid/$videoFileName");
          Uint8List Videobytes = videoFile.readAsBytesSync();
          final videoMetadata = SettableMetadata(contentType: mime(videoFile.path));
          await videoRef.putData(Videobytes, videoMetadata);
          String videoUrl = await videoRef.getDownloadURL();
          print("suceessfull");
          print(videoUrl);

          //upload thumbnail
          Uint8List thumbnailbytes = await getThumbail(videoFile);
          print("thumbnail is ready.");
          final tempDir = await getTemporaryDirectory();
          File tfile = await File('${tempDir.path}/image.png').create();
          tfile.writeAsBytesSync(thumbnailbytes);
          print(tfile.path);
          final thumbnailMetadata = SettableMetadata(contentType: mime(tfile.path));
          final thumbnailRef =
          firebaseStorage.ref().child("users/$currentUserUid/Thumbnail${videoFileName}.png");
          await thumbnailRef.putData(thumbnailbytes, thumbnailMetadata);
          String thumbnailUrl = await thumbnailRef.getDownloadURL();
          print("suceessfull");
          print(thumbnailUrl);


          if (docId != null) {
            DocumentReference vDocRef = firestore.collection("DB_negocio").doc(docId).collection("Videos").doc();

            vDocRef.set({
              'video': videoUrl,
              'thumbnail': thumbnailUrl,
              'uid': vDocRef.id,
            }).
            then((value) {
              Fluttertoast.showToast(msg: "Vídeo actualizado");
            });
          }
        } else {
          const snackBar = SnackBar(
            content: Text('El tamaño del video debe estar entre 2 MB y 50 MB.',style: TextStyle(
              color: Colors.black
            ),),
            showCloseIcon: true,
            backgroundColor: Colors.white,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("error");
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<Uint8List> getThumbail(File file)async{
    final uint8List = await VideoThumbnail.thumbnailData(
        video: file.path,
      imageFormat: ImageFormat.PNG,
    );

    return uint8List!;
  }


  Future deleteVideo(String uid,String videoUrl,String thumbnailUrl) async {
    print("pref");
    print(videoUrl);
    final Reference videoPrevRef = firebaseStorage.refFromURL(videoUrl);
    final Reference thumbPrevRef = firebaseStorage.refFromURL(thumbnailUrl);
    try {
      try{
        await videoPrevRef.delete();
        await thumbPrevRef.delete();
      }
      catch(e){
        print("cannot delete from firebase storage");
        print(e);
      }
      print("storage file Deleted");
      await firestore.collection("DB_negocio").doc(docId).collection("Videos").doc(uid).delete()
          .then((value) {
        Fluttertoast.showToast(msg: "Vídeo actualizado");
      });
    } catch (e) {
      print("cannot delte");
      print(e.toString());
    }
  }

}
