import 'package:docucare/routes/routes.dart';
import 'package:docucare/screens/splash_screen/view/splash_screen.dart';
import 'package:docucare/styles/app_themes.dart';
import 'package:docucare/utils/app_constant.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/global_keys.dart';

class DocucareApp extends ConsumerWidget {
  const DocucareApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstant.appTitle,
          navigatorKey: navigatorKey,
          routes: routes,
          theme: AppTheme.appTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
