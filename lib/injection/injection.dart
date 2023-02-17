import 'package:get_it/get_it.dart';
import 'package:youtube_app/services/api_client.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton(() => APIClient());
}
