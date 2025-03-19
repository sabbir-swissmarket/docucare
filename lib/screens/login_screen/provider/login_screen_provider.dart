import 'package:docucare/helper/enum_data.dart';
import 'package:docucare/routes/route_names.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/global_keys.dart';
import 'package:docucare/utils/shared_pref_keys.dart';
import 'package:docucare/utils/shared_pref_manager.dart';
import 'package:docucare/utils/utils.dart';

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final showPasswordProvider = StateProvider<bool>((ref) => true);
final formErrorProvider =
    StateProvider.autoDispose<Map<String, String>>((ref) => {});

final loginNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>(
        (ref) => LoginStateNotifier());

@immutable
abstract class LoginState {}

class InitLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class LoadedLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final String message;

  ErrorLoginState({required this.message});
}

class LoginStateNotifier extends StateNotifier<LoginState> {
  LoginStateNotifier() : super(InitLoginState());
  final utils = locator.get<Utils>();
  final supabase = Supabase.instance.client;
  final sharedPrefManager = locator.get<SharedPrefManager>();

  void validateForm(WidgetRef ref) {
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    final errors = <String, String>{};

    if (email.isEmpty) {
      errors['email'] = 'Email cannot be empty';
    } else if (!utils.isEmailValid(email)) {
      errors['email'] = 'Enter a valid email';
    }

    if (password.isEmpty) {
      errors['password'] = 'Password cannot be empty';
    } else if (password.length < 6) {
      errors['password'] = 'Password must be at least 6 characters long';
    }

    ref.read(formErrorProvider.notifier).state = errors;

    if (errors.isEmpty) {
      login(ref, email: email, password: password);
    }
  }

  Future<void> login(WidgetRef ref,
      {required String email, required String password}) async {
    try {
      state = LoadingLoginState();

      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      state = InitLoginState();
      if (response.user != null) {
        invalidateProviders(ref);
        await sharedPrefManager.saveEnumValue(
            SharedPrefKeys.showScreen, Screens.driveLoginScreen);
        await sharedPrefManager.saveObjectValue(
            SharedPrefKeys.userData, response.user);
        Navigator.pushNamed(
            navigatorKey.currentContext!, RoutesNames.driveLoginScreen);
      }
    } on AuthException catch (e) {
      state = ErrorLoginState(message: e.message);
    } catch (e) {
      state = ErrorLoginState(message: "Something went wrong. Try again.");
    }
  }

  /// Invalidate provider
  void invalidateProviders(WidgetRef ref) {
    ref.invalidate(emailProvider);
    ref.invalidate(passwordProvider);
    ref.invalidate(showPasswordProvider);
  }

  /// Show an error toast message with the provided error message
  void showError(String message) {
    utils.showToast(message, true, utils.checkPlatformIsIOS());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = InitLoginState();
    });
  }
}
