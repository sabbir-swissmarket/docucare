import 'package:docucare/custom_widgets/custom_back_button.dart';
import 'package:docucare/custom_widgets/custom_button.dart';
import 'package:docucare/custom_widgets/custom_textfield.dart';
import 'package:docucare/custom_widgets/loader.dart';
import 'package:docucare/routes/route_names.dart';
import 'package:docucare/screens/registration_screen/provider/registration_provider.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/screen_config.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final width = locator.get<SizeConfig>().getFullWidth();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref
            .read(registrationNotifierProvider.notifier)
            .invalidateProviders(ref);
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              RegistrationState state = ref.watch(registrationNotifierProvider);
              if (state is InitRegistrationState) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(
                          onPressed: () {
                            ref
                                .read(registrationNotifierProvider.notifier)
                                .invalidateProviders(ref);
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Create an Account",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Establish a secure account for cloud document storage.",
                          style: AppStyles.bodyExtraLarge,
                        ),
                        const SizedBox(height: 30),
                        formWidgets(
                          ref,
                          emailController: emailController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                        ),
                        const SizedBox(height: 10),
                        policyCheckWidget(ref),
                        const SizedBox(height: 30),
                        CustomButton(
                          text: "Next",
                          width: width,
                          onPressed: () {
                            // ref
                            //     .read(registrationNotifierProvider.notifier)
                            //     .validateForm(ref);
                            Navigator.pushNamed(
                                context, RoutesNames.emailConfirmationScreen);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is LoadingRegistrationState) {
                return const Center(child: Loader());
              } else if (state is ErrorRegistrationState) {
                ref
                    .read(registrationNotifierProvider.notifier)
                    .showError(state.message);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget formWidgets(WidgetRef ref,
      {required TextEditingController emailController,
      required TextEditingController passwordController,
      required TextEditingController confirmPasswordController}) {
    final emailError = ref.watch(formErrorProvider)['email'];
    final passwordError = ref.watch(formErrorProvider)['password'];
    final confirmPasswordError =
        ref.watch(formErrorProvider)['confirmPassword'];
    final showPassword = ref.watch(showPasswordProvider);
    final showConfirmPassword = ref.watch(showConfirmPasswordProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelTextWidget("Email"),
        const SizedBox(height: 10),
        CustomTextfield(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: "example@example.com",
          errorText: emailError,
          onChanged: (value) {
            ref.read(emailProvider.notifier).update((state) => value);
          },
        ),
        const SizedBox(height: 20),
        labelTextWidget("Password"),
        const SizedBox(height: 10),
        CustomTextfield(
          controller: passwordController,
          obscureText: showPassword,
          hintText: "********",
          errorText: passwordError,
          suffixIcon: InkWell(
            onTap: () {
              ref
                  .read(showPasswordProvider.notifier)
                  .update((state) => !showPassword);
            },
            child: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility,
              color: AppColors.iconColor,
            ),
          ),
          onChanged: (value) {
            ref.read(passwordProvider.notifier).update((state) => value);
          },
        ),
        const SizedBox(height: 20),
        labelTextWidget("Confirm Password"),
        const SizedBox(height: 10),
        CustomTextfield(
          controller: confirmPasswordController,
          obscureText: showConfirmPassword,
          hintText: "********",
          errorText: confirmPasswordError,
          suffixIcon: InkWell(
            onTap: () {
              ref
                  .read(showConfirmPasswordProvider.notifier)
                  .update((state) => !showConfirmPassword);
            },
            child: Icon(
              showConfirmPassword ? Icons.visibility_off : Icons.visibility,
              color: AppColors.iconColor,
            ),
          ),
          onChanged: (value) {
            ref.read(confirmPasswordProvider.notifier).update((state) => value);
          },
        ),
      ],
    );
  }

  Widget labelTextWidget(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget policyCheckWidget(WidgetRef ref) {
    final termsAccepted = ref.watch(termsAcceptedProvider);
    final termsAcceptedError = ref.watch(formErrorProvider)['termsAccepted'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: termsAccepted,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (value) {
                if (value != null) {
                  ref
                      .read(termsAcceptedProvider.notifier)
                      .update((state) => value);
                }
              },
            ),
            const Expanded(
              child: Text(
                "I agree to the terms and privacy policy of DocuCare",
                style: AppStyles.hintStyle,
              ),
            ),
          ],
        ),
        termsAcceptedError != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  termsAcceptedError,
                  style: AppStyles.hintStyle
                      .copyWith(color: AppColors.warningColor),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
