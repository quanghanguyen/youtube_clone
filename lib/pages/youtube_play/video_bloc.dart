import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:youtube_app/pages/youtube_play/video_event.dart';
import 'package:youtube_app/pages/youtube_play/video_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  YoutubePlayerController? youtubePlayerController;
  bool isPlayer = false;
  VideoBloc() : super(VideoPlayerIdleState()) {
    on<PlayVideoEvent>(_playVideo);
    on<PauseVideoEvent>(_pauseVideo);
    on<ResumeVideoEvent>(_resumeVideo);
  }

  void _playVideo(PlayVideoEvent event, Emitter<VideoState> emit) async {
    youtubePlayerController =
        YoutubePlayerController(initialVideoId: event.video.id!);
    emit(
        VideoPlayerState(event.video, youtubePlayerController, isPlayer: true));
  }

  void _pauseVideo(PauseVideoEvent event, Emitter<VideoState> emit) async {
    emit(VideoPlayerState(state.currentVideo, youtubePlayerController,
        isPlayer: false));
  }

  void _resumeVideo(ResumeVideoEvent event, Emitter<VideoState> emit) async {
    emit(VideoPlayerState(state.currentVideo, youtubePlayerController,
        isPlayer: true));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
