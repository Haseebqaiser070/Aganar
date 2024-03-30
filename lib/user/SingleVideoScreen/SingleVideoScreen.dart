import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../flutter_flow/flutter_flow_theme.dart';


class SingleVideoScreen extends StatefulWidget {
  SingleVideoScreen({Key? key,required this.url}) : super(key: key);
  final url;
  @override
  State<SingleVideoScreen> createState() => _SingleVideoScreenState();
}

class _SingleVideoScreenState extends State<SingleVideoScreen> {
  bool isPlaying = false;
  RxDouble progress = 0.0.obs;
  late VideoPlayerController videoPlayerController;
  RxBool isBuffering = false.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeVideo(widget.url);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(videoPlayerController.value.isInitialized){
      videoPlayerController.dispose();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          elevation: 0.0,
          title: Text("vídeos de aplicaciones"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: FlutterFlowTheme.of(context).accent3,),
            onPressed: (){
              if(videoPlayerController.value.isInitialized){
                videoPlayerController.dispose();
              }
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            videoPlayerController.value.isInitialized?
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 249, 43, 249),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(0, -1))
                      ],
                      border: Border.all(color: Colors.white, width: 1)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ),
                ),
                Obx(() => isBuffering.value?Text("Buffering...",style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),):SizedBox()),
              ],
            ):CircularProgressIndicator(),

            Positioned(
              bottom: 0,
              child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() => Expanded(
                      child: Slider(value: progress.value,
                        min: 0.0,
                        max: videoPlayerController.value.duration.inSeconds.toDouble(),
                        onChanged: (v){
                          progress.value = v;
                          videoPlayerController.seekTo(Duration(seconds: progress.value.round()));
                        },
                        activeColor: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    )),
                    InkWell(
                      onTap: (){
                        if(isPlaying){
                          isPlaying = false;
                          videoPlayerController.pause();
                        }
                        else{
                          isPlaying = true;
                          videoPlayerController.play();
                        }
                        setState(() {

                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        alignment: Alignment.center,
                        child: isPlaying?Icon(Icons.pause,color: Colors.white,):Icon(Icons.play_arrow,color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future initializeVideo(String url) async {
    videoPlayerController =
    VideoPlayerController.networkUrl(Uri.parse(url));
    await videoPlayerController.initialize();
    await videoPlayerController.play();
    // videoPlayerController.setLooping(true);
    setState(() {
      isPlaying = true;
    });
    print(videoPlayerController.value.duration);
    videoPlayerController.addListener(() {
      // print(videoPlayerController.value.position);
      progress.value = videoPlayerController.value.position.inSeconds.toDouble();
      print(progress.value);
      print(videoPlayerController.value.isBuffering);
      isBuffering.value = videoPlayerController.value.isBuffering;
      if(videoPlayerController.value.isCompleted){
        setState(() {
          isPlaying = false;
        });
      }
    });
    // return Container(
    //   margin: EdgeInsets.all(5),
    //   decoration: BoxDecoration(
    //       color: FlutterFlowTheme.of(context).secondaryBackground,
    //       borderRadius: BorderRadius.circular(10),
    //       boxShadow: [
    //         BoxShadow(
    //             color: Color.fromARGB(255, 249, 43, 249),
    //             blurRadius: 5,
    //             spreadRadius: 2,
    //             offset: Offset(0, -1))
    //       ],
    //       border: Border.all(color: Colors.white, width: 1)),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: AspectRatio(
    //       aspectRatio: videoPlayerController.value.aspectRatio,
    //       child: VideoPlayer(videoPlayerController),
    //     ),
    //   ),
    // );
  }

}
