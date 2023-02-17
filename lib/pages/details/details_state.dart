import 'package:equatable/equatable.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';
import 'package:youtube_app/models/popular_video/thumbnails_video.dart';

abstract class DetailState extends Equatable {
  // hàm dựng để các class kế thừa có thể hợp lệ
  const DetailState();

  @override
  List<Object> get props => [];
}

class VideoStateEmpty extends DetailState {}

class VideoRelativeStateLoading extends DetailState {
  final bool isFirstFetch;
  final List<Items> oldVideo;

  const VideoRelativeStateLoading(
      {required this.isFirstFetch, this.oldVideo = const []});

  @override
  List<Object> get props => [isFirstFetch];
}

class VideoRelativeStateLoadFinished extends DetailState {
  late List<Items> videos = [];
  final String nextToken;
  final String relativeId;

  VideoRelativeStateLoadFinished(this.videos, this.nextToken, this.relativeId);

  @override
  List<Object> get props => [videos, nextToken, relativeId];

  VideoRelativeStateLoadFinished copyWith(
      List<Items>? videos, String? nextToken, String? relativeId) {
    return VideoRelativeStateLoadFinished(videos ?? this.videos,
        nextToken ?? this.nextToken, relativeId ?? this.relativeId);
  }
}
