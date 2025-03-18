import 'package:docucare/docucare_app.dart';
import 'package:docucare/utils/core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const ProviderScope(child: DocucareApp()));
}
