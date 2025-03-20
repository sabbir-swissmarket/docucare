import 'package:docucare/routes/route_names.dart';
import 'package:docucare/screens/drive_login_screen/view/drive_login_screen.dart';
import 'package:docucare/screens/email_confirmation_screen/view/email_confirmation_screen.dart';
import 'package:docucare/screens/home/folder_view/view/folder_view.dart';
import 'package:docucare/screens/home/upload_screen/view/upload_screen.dart';
import 'package:docucare/screens/home/view/home.dart';
import 'package:docucare/screens/login_screen/view/login_screen.dart';
import 'package:docucare/screens/registration_screen/view/registration_screen.dart';
import 'package:docucare/screens/settings_screen/view/settings_view.dart';
import 'package:docucare/screens/welcome_screen/view/welcome_screen.dart';
import 'package:docucare/utils/core.dart';

final Map<String, WidgetBuilder> routes = {
  RoutesNames.welcomeScreen: (context) => const WelcomeScreen(),
  RoutesNames.registrationScreen: (context) => const RegistrationScreen(),
  RoutesNames.emailConfirmationScreen: (context) =>
      const EmailConfirmationScreen(),
  RoutesNames.loginScreen: (context) => const LoginScreen(),
  RoutesNames.driveLoginScreen: (context) => const DriveLoginScreen(),
  RoutesNames.home: (context) => const Home(),
  RoutesNames.folderViewScreen: (context) => const FolderViewScreen(),
  RoutesNames.uploadDocumentScreen: (context) => const UploadDocumentScreen(),
  RoutesNames.settingsScreen: (context) => const SettingsScreen(),
};
