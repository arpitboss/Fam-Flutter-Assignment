import 'package:fam_flutter_assignment/controllers/card_controller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/services/api_service.dart';
import '../../models/services/storage_service.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setupDependencies() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // HTTP Client
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());

  // Data Sources
  serviceLocator.registerLazySingleton<ApiHandler>(
      () => ApiHandlerImplementation(client: serviceLocator()));
  serviceLocator.registerLazySingleton<LocalStorage>(
      () => LocalStorageImpl(sharedPreferences: serviceLocator()));

  Get.lazyPut<ApiHandler>(() => serviceLocator<ApiHandler>());
  Get.lazyPut<LocalStorage>(() => serviceLocator<LocalStorage>());

  // Controller
  Get.lazyPut<CardController>(() => CardController(
        apiHandler: Get.find<ApiHandler>(),
        localStorage: Get.find<LocalStorage>(),
      ));
}
