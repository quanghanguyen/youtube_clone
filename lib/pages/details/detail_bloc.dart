import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';
import 'package:youtube_app/pages/details/details_state.dart';
import 'package:youtube_app/services/api_client.dart';
import 'package:youtube_app/services/video_services.dart';
import '../../injection/injection.dart';
import 'details_event.dart';

class DetailsBloc extends Bloc<DetailEvent, DetailState> {
  final videoServices = getIt<APIClient>().videoServices;

  DetailsBloc() : super(VideoStateEmpty()) {
    on<LoadRelativeVideoEvent>(_onLoadVideos);
    on<LoadMoreVideoEvent>(_onLoadMoreVideos);
  }

  // load relative videos
  void _onLoadVideos(
      LoadRelativeVideoEvent event, Emitter<DetailState> emit) async {
    final dataEvent = event;
    emit(const VideoRelativeStateLoading(isFirstFetch: true));
    try {
      // fetch api
      final response = await videoServices.getRelativeVideos({
        'relatedToVideoId': dataEvent.videoId,
        'part': ['snippet'],
        'type': 'video'
      });
      debugPrint('GET relative videos');
      emit(VideoRelativeStateLoadFinished(
          response.items, response.nextPageToken ?? '', dataEvent.videoId));
    } on DioError catch (e) {
      debugPrint(e.message);
    }
  }

  // Load more videos
  void _onLoadMoreVideos(
      LoadMoreVideoEvent event, Emitter<DetailState> emit) async {
    List<Items> videos = [];
    final currentState = state;
    if (currentState is VideoRelativeStateLoading) {
      return;
    }

    var nextToken = '';
    var relativeId = '';

    if (currentState is VideoRelativeStateLoadFinished) {
      videos.addAll(currentState.videos);
      nextToken = currentState.nextToken;
      relativeId = currentState.relativeId;
    }

    emit(VideoRelativeStateLoading(isFirstFetch: false, oldVideo: videos));
    try {
      final response = await videoServices.getRelativeVideos({
        'relatedToVideoId': relativeId,
        'part': ['snippet'],
        'pageToken': nextToken,
        'type': 'video'
      });
      videos.addAll(response.items);
      emit(VideoRelativeStateLoadFinished(
          videos, response.nextPageToken ?? '', relativeId));
    } on DioError catch (e) {
      debugPrint(e.message);
    }
  }
}