class RoutesNames {
  static final RoutesNames _routesNames = RoutesNames._internal();

  factory RoutesNames() {
    return _routesNames;
  }

  RoutesNames._internal();

  static String splashScreen = '/splash_screen';
  static String welcomeScreen = '/welcome_screen';
  static String registrationScreen = '/registration_screen';
  static String home = '/home';
}
