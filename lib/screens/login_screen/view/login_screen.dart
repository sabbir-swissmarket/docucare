import 'package:docucare/custom_widgets/custom_back_button.dart';
import 'package:docucare/custom_widgets/custom_button.dart';
import 'package:docucare/custom_widgets/custom_textfield.dart';
import 'package:docucare/custom_widgets/loader.dart';
import 'package:docucare/routes/route_names.dart';
import 'package:docucare/screens/login_screen/provider/login_screen_provider.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/screen_config.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final width = locator.get<SizeConfig>().getFullWidth();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref.read(loginNotifierProvider.notifier).invalidateProviders(ref);
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              LoginState state = ref.watch(loginNotifierProvider);
              if (state is InitLoginState) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(
                          onPressed: () {
                            ref
                                .read(loginNotifierProvider.notifier)
                                .invalidateProviders(ref);
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Login to your Account.",
                          style: AppStyles.bodyExtraLarge,
                        ),
                        const SizedBox(height: 30),
                        formWidgets(
                          ref,
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                        const SizedBox(height: 60),
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
              } else if (state is LoadingLoginState) {
                return const Center(child: Loader());
              } else if (state is ErrorLoginState) {
                ref
                    .read(loginNotifierProvider.notifier)
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
      required TextEditingController passwordController}) {
    final emailError = ref.watch(formErrorProvider)['email'];
    final passwordError = ref.watch(formErrorProvider)['password'];
    final showPassword = ref.watch(showPasswordProvider);
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
}
