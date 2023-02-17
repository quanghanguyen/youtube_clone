import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';
import 'package:youtube_app/pages/youtube_play/video_bloc.dart';
import 'package:youtube_app/pages/youtube_play/video_event.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final Items video;
  const VideoPlayer({super.key, required this.video});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController youtubePlayerController;

  @override
  void initState() {
    super.initState();
    youtubePlayerController = YoutubePlayerController(
        initialVideoId: widget.video.id!,
        flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            disableDragSeek: true,
            loop: true,
            isLive: false,
            enableCaption: false));
  }

  @override
  void deactivate() {
    super.deactivate();
    youtubePlayerController.pause();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("DISPOSE");
    youtubePlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoBloc = BlocProvider.of<VideoBloc>(context);
    return SizedBox(
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: YoutubePlayer(
        controller: youtubePlayerController,
        showVideoProgressIndicator: false,
        onReady: () {
          videoBloc.add(PlayVideoEvent(widget.video));
        },
      ),
    );
  }
}
