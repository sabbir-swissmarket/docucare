class RoutesNames {
  static final RoutesNames _routesNames = RoutesNames._internal();

  factory RoutesNames() {
    return _routesNames;
  }

  RoutesNames._internal();

  static String splashScreen = '/splash_screen';
  static String welcomeScreen = '/welcome_screen';
  static String registrationScreen = '/registration_screen';
  static String emailConfirmationScreen = '/email_confirmation_screen';
  static String loginScreen = '/login_screen';
  static String driveLoginScreen = '/drive_login_screen';
  static String home = '/home';
  static String folderViewScreen = '/folder_view';
  static String uploadDocumentScreen = '/upload_document_screen';
}
