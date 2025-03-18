import 'package:docucare/routes/route_names.dart';
import 'package:docucare/screens/registration_screen/view/registration_screen.dart';
import 'package:docucare/screens/welcome_screen/view/welcome_screen.dart';
import 'package:docucare/utils/core.dart';

final Map<String, WidgetBuilder> routes = {
  RoutesNames.welcomeScreen: (context) => const WelcomeScreen(),
  RoutesNames.registrationScreen: (context) => const RegistrationScreen(),
};
