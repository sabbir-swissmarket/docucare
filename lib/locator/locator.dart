import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/screen_config.dart';
import 'package:docucare/utils/utils.dart';

var locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<SizeConfig>(() => SizeConfig());
  locator.registerLazySingleton<Utils>(() => Utils());
}
