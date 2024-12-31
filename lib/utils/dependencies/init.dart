import 'package:fam_flutter_assignment/controllers/card_controller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/services/api_service.dart';
import '../../models/services/storage_service.dart';

final GetIt serviceLocator =
    GetIt.instance; // Singleton instance of GetIt for dependency injection

Future<void> setupDependencies() async {
  // Set up SharedPreferences for local storage
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Set up HTTP client for API requests
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());

  // Register API handler with the HTTP client
  serviceLocator.registerLazySingleton<ApiHandler>(
      () => ApiHandlerImplementation(client: serviceLocator()));

  // Register local storage with SharedPreferences
  serviceLocator.registerLazySingleton<LocalStorage>(
      () => LocalStorageImpl(sharedPreferences: serviceLocator()));

  // Register dependencies with GetX for state management
  Get.lazyPut<ApiHandler>(() => serviceLocator<ApiHandler>());
  Get.lazyPut<LocalStorage>(() => serviceLocator<LocalStorage>());

  // Register the CardController with its dependencies
  Get.lazyPut<CardController>(() => CardController(
        apiHandler: Get.find<ApiHandler>(),
        localStorage: Get.find<LocalStorage>(),
      ));
}
