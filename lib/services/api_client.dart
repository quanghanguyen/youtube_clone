import 'package:dio/dio.dart';
import 'package:youtube_app/services/video_services.dart';
import '/utils/constants.dart';

class APIClient {
  final Dio dio = Dio();
  late VideoServices videoServices;

  APIClient() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters.addAll({'key': apiKey});
        return handler.next(options);
      },
      onError: (e, handler) {
        return handler.next(e);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
    ));

    videoServices = VideoServices(dio);
  }
}
