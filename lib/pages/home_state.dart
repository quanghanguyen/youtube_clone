import 'package:equatable/equatable.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';

abstract class HomeState extends Equatable {
  const HomeState();

// why override here
  @override
  List<Object> get props => [];
}

class VideoStateEmpty extends HomeState {}

class VideoStateLoading extends HomeState {
  final bool isFirstFetch;
  final List<Items> oldVideos;

  const VideoStateLoading(
      {required this.isFirstFetch, this.oldVideos = const []});

// why override here
  @override
  List<Object> get props => [isFirstFetch];
}

class VideoStateLoadFinished extends HomeState {
  late List<Items> videos = [];
  final String nextToken;

  VideoStateLoadFinished(this.videos, this.nextToken);

  @override
  List<Object> get props => [videos, nextToken];

  VideoStateLoadFinished copyWith(List<Items>? videos, String? nextToken) {
    return VideoStateLoadFinished(
        videos ?? this.videos, nextToken ?? this.nextToken);
  }
}

class VideoStateLoadFail extends HomeState {
  final String error;

  const VideoStateLoadFail(this.error);

  @override
  List<Object> get props => [error];
}