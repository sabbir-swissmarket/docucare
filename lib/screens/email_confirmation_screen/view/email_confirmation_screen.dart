import 'package:docucare/custom_widgets/custom_back_button.dart';
import 'package:docucare/custom_widgets/custom_button.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/screen_config.dart';

class EmailConfirmationScreen extends ConsumerWidget {
  const EmailConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = locator.get<SizeConfig>().getFullWidth();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Email Confirmation",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                "We have sent verification link to your email",
                style: AppStyles.bodyExtraLarge,
              ),
              const SizedBox(height: 32),
              CustomButton(
                onPressed: () {},
                text: "Open Email",
                width: width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
