import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.asset("assets/videos/video.mov")..initialize().then((value){
      videoPlayerController.play();
    });
    videoPlayerController.addListener(() {
      if(videoPlayerController.value.isCompleted){
        print("completed");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: videoPlayerController.value.isInitialized
            ? AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: VideoPlayer(videoPlayerController),
        )
            : SizedBox(),
      ),
    );
  }
}
