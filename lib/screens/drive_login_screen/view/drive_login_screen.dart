import 'package:docucare/custom_widgets/custom_back_button.dart';
import 'package:docucare/custom_widgets/loader.dart';
import 'package:docucare/screens/drive_login_screen/provider/drive_login_provider.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:docucare/utils/core.dart';

class DriveLoginScreen extends ConsumerWidget {
  const DriveLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final width = locator.get<SizeConfig>().getFullWidth();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: Consumer(
        builder: (context, ref, child) {
          DriveLoginState state = ref.watch(driveLoginNotifierProvider);
          if (state is InitDriveLoginState || state is LoadingDriveLoginState) {
            return Padding(
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
                    "Proceed with Google",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      ref
                          .read(driveLoginNotifierProvider.notifier)
                          .loginWithGoogle();
                    },
                    child: Text(
                      "Login to your Account.",
                      style: AppStyles.bodyExtraLarge.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Image.asset(
                    'assets/images/drive-logo.png',
                    width: 220,
                    height: 220,
                  ),
                  const SizedBox(height: 32),
                  state is LoadingDriveLoginState
                      ? const Center(child: Loader())
                      : const SizedBox.shrink()
                ],
              ),
            );
          } else if (state is ErrorDriveLoginState) {
            ref
                .read(driveLoginNotifierProvider.notifier)
                .showError(state.message);
          }
          return const SizedBox.shrink();
        },
      )),
    );
  }
}
