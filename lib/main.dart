import 'package:docucare/docucare_app.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await dotenv.load(fileName: Environment.fileName);
  await Supabase.initialize(
    url: Environment.supabaseUrl,
    anonKey: Environment.supabaseKey,
  );
  runApp(const ProviderScope(child: DocucareApp()));
}
