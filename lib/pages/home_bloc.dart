import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app/injection/injection.dart';
import 'package:youtube_app/models/popular_video/item_video.dart';
import 'package:youtube_app/pages/home_event.dart';
import 'package:youtube_app/pages/home_state.dart';
import 'package:youtube_app/services/api_client.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final videoService = getIt<APIClient>().videoServices;

  HomeBloc() : super(VideoStateEmpty()) {
    on<LoadVideoEvent>(_onLoadVideos);
    on<LoadMoreEvent>(_onLoadMoreVideo);
    on<SearchEvent>(_onSearchEvent);
  }

  // Load video from api
  void _onLoadVideos(LoadVideoEvent event, Emitter<HomeState> emit) async {
    emit(const VideoStateLoading(isFirstFetch: true));
    try {
      final response = await videoService.getPopularVideo({
        'chart': 'mostPopular',
        'part': ['snippet', 'statistics', 'player']
      });

      if (response.items.isEmpty) {
        emit(VideoStateEmpty());
      } else {
        emit(VideoStateLoadFinished(
            response.items, response.nextPageToken ?? ''));
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      emit(VideoStateLoadFail(e.message));
    }
  }

  void _onLoadMoreVideo(LoadMoreEvent event, Emitter<HomeState> emit) async {
    List<Items> videos = [];
    final currentState = state;
    if (currentState is VideoStateLoading) {
      return;
    }

    var nextToken = '';
    if (currentState is VideoStateLoadFinished) {
      videos.addAll(currentState.videos);
      nextToken = currentState.nextToken;
    }

    emit(VideoStateLoading(isFirstFetch: false, oldVideos: videos));

    try {
      final response = await videoService.getPopularVideo({
        'chart': 'mostPopular',
        'part': ['snippet', 'statistics', 'player'],
        'pageToken': nextToken
      });
      videos.addAll(response.items);
      emit(VideoStateLoadFinished(videos, response.nextPageToken ?? ''));
    } on DioError catch (e) {
      debugPrint(e.message);
      emit(VideoStateLoadFail(e.message));
    }
  }

  // search function
  void _onSearchEvent(SearchEvent event, Emitter<HomeState> emit) async {
    emit(const VideoStateLoading(isFirstFetch: true));

    try {
      final response = await videoService.searchVideo({
        'q': event.text,
        'part': ['snippet'],
        'type': 'video'
      });
      debugPrint("Error");
      if (response.items.isEmpty) {
        emit(VideoStateEmpty());
      } else {
        emit(VideoStateLoadFinished(
            response.items, response.nextPageToken ?? ''));
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      emit(VideoStateLoadFail(e.message));
    }
  }
}
