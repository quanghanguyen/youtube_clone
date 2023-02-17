import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

abstract class VideoState extends Equatable {
  Items? currentVideo;
  YoutubePlayerController? videoController;
  VideoState(this.currentVideo);

  @override
  List<Object?> get props => [currentVideo, videoController];
}

class VideoPlayerIdleState extends VideoState {
  VideoPlayerIdleState() : super(null);
}

class VideoPlayerState extends VideoState {
  final bool isPlayer;
  final bool isLoop;
  final bool isAutoNext;

  VideoPlayerState(Items? currentVideo, YoutubePlayerController? controller,
      {required this.isPlayer, this.isLoop = false, this.isAutoNext = false})
      : super(currentVideo);

  @override
  List<Object?> get props => [isPlayer, isLoop, isAutoNext, currentVideo];

  VideoPlayerState copyWith(
      {Items? video,
      YoutubePlayerController? controller,
      bool? isPlayer,
      bool? isLoop,
      bool? isAutoNext}) {
    return VideoPlayerState(
        video ?? currentVideo, controller ?? videoController,
        isPlayer: isPlayer ?? this.isPlayer,
        isLoop: isLoop ?? this.isLoop,
        isAutoNext: isAutoNext ?? this.isAutoNext);
  }
}