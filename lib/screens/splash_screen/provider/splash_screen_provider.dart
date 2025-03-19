import 'dart:async';

import 'package:docucare/helper/enum_data.dart';
import 'package:docucare/routes/route_names.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/global_keys.dart';
import 'package:docucare/utils/shared_pref_keys.dart';
import 'package:docucare/utils/shared_pref_manager.dart';

/// Auto dispose notifier provider for managing the state of splash screen
final splashScreenNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SplashScreenProvider, void>(
        SplashScreenProvider.new);

/// A auto dipsose notifier responsible for managing the state of the splash screen
class SplashScreenProvider extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    await navigateToPage();
  }

  Future<void> navigateToPage() async {
    Future.delayed(const Duration(seconds: 2), () async {
      navigatorKey.currentState!
          .pushReplacementNamed(RoutesNames.welcomeScreen);
      String? enumValue = await locator
          .get<SharedPrefManager>()
          .getEnumValue(SharedPrefKeys.showScreen);
      debugPrint(enumValue);
      var showScreen = EnumToString.fromString(
          Screens.values, enumValue ?? Screens.welcomeScreen.toString());
      switch (showScreen) {
        case Screens.welcomeScreen:
          navigatorKey.currentState!
              .pushReplacementNamed(RoutesNames.welcomeScreen);
          break;
        case Screens.emailVerificationScreen:
          navigatorKey.currentState!
              .pushReplacementNamed(RoutesNames.emailConfirmationScreen);
          break;
        case Screens.loginScreen:
          navigatorKey.currentState!
              .pushReplacementNamed(RoutesNames.loginScreen);
          break;
        case Screens.driveLoginScreen:
          navigatorKey.currentState!
              .pushReplacementNamed(RoutesNames.driveLoginScreen);
          break;
        case Screens.home:
          navigatorKey.currentState!.pushReplacementNamed(RoutesNames.home);
          break;
        default:
          navigatorKey.currentState!
              .pushReplacementNamed(RoutesNames.welcomeScreen);
      }
    });
  }
}
