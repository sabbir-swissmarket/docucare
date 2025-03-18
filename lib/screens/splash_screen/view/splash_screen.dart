import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/screen_config.dart';

import '../provider/splash_screen_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    locator.get<SizeConfig>().init(context);
    ref.watch(splashScreenNotifierProvider);
    return Scaffold(
      body: Center(
        child: Text(
          "DocuCare",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ),
    );
  }
}
