import 'package:equatable/equatable.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object?> get props => [];
}

// Play Video Event
class PlayVideoEvent extends VideoEvent {
  final Items video;

  const PlayVideoEvent(this.video);

  @override
  List<Object?> get props => [video];
}

class PauseVideoEvent extends VideoEvent {
  @override
  const PauseVideoEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ResumeVideoEvent extends VideoEvent {
  const ResumeVideoEvent();
  
  @override
  List<Object?> get props => throw UnimplementedError();
}


