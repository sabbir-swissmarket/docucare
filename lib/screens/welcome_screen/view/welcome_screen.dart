import 'package:docucare/custom_widgets/custom_button.dart';
import 'package:docucare/routes/route_names.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/screen_config.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = locator.get<SizeConfig>().getFullWidth();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to DocuCare",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Secure, private, and always accessible in your cloud.",
                  style: AppStyles.bodyExtraLarge,
                ),
                const SizedBox(height: 32),
                Image.asset(
                  'assets/images/fingerprint.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RoutesNames.registrationScreen);
                  },
                  text: "Register",
                  width: width,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesNames.loginScreen);
                  },
                  text: "Signin",
                  width: width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
