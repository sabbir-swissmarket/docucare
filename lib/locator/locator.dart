import 'package:docucare/api_services/google_signin_api_service.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/screen_config.dart';
import 'package:docucare/utils/shared_pref_manager.dart';
import 'package:docucare/utils/utils.dart';

var locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<SizeConfig>(() => SizeConfig());
  locator.registerLazySingleton<Utils>(() => Utils());
  locator.registerLazySingleton<SharedPrefManager>(() => SharedPrefManager());
  locator.registerLazySingleton<GoogleSigninApiService>(
      () => GoogleSigninApiService());
}
