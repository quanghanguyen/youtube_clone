import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube_app/models/popular_video/popular_video.dart';
part 'video_services.g.dart';

@RestApi(baseUrl: 'https://youtube.googleapis.com/youtube/v3/')
abstract class VideoServices {
  factory VideoServices(Dio dio, {String baseUrl}) = _VideoServices;

  // get videos
  @GET('videos')
  Future<PopularVideo> getPopularVideo(@Queries() Map<String, dynamic> params);

  // get relative video
  @GET('search')
  Future<PopularVideo> getRelativeVideos(
      @Queries() Map<String, dynamic> params);

  @GET('search')
  Future<PopularVideo> searchVideo(@Queries() Map<String, dynamic> params);
}
