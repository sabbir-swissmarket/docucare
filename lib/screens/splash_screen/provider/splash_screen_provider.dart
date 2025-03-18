import 'dart:async';

import 'package:docucare/routes/route_names.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/global_keys.dart';

/// Auto dispose notifier provider for managing the state of splash screen
final splashScreenNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SplashScreenProvider, void>(
        SplashScreenProvider.new);

/// A auto dipsose notifier responsible for managing the state of the splash screen
class SplashScreenProvider extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    navigateToPage();
  }

  void navigateToPage() {
    Future.delayed(const Duration(seconds: 2), () {
      navigatorKey.currentState!
          .pushReplacementNamed(RoutesNames.welcomeScreen);
    });
  }
}
