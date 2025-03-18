import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/utils.dart';

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final confirmPasswordProvider = StateProvider<String>((ref) => '');
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
final showPasswordProvider = StateProvider<bool>((ref) => true);
final showConfirmPasswordProvider = StateProvider<bool>((ref) => true);
final formErrorProvider =
    StateProvider.autoDispose<Map<String, String>>((ref) => {});

final registrationNotifierProvider =
    StateNotifierProvider<RegistrationStateNotifier, RegistrationState>(
        (ref) => RegistrationStateNotifier());

@immutable
abstract class RegistrationState {}

class InitRegistrationState extends RegistrationState {}

class LoadingRegistrationState extends RegistrationState {}

class LoadedRegistrationState extends RegistrationState {}

class ErrorRegistrationState extends RegistrationState {
  final String message;

  ErrorRegistrationState({required this.message});
}

class RegistrationStateNotifier extends StateNotifier<RegistrationState> {
  RegistrationStateNotifier() : super(InitRegistrationState());
  final utils = locator.get<Utils>();

  void validateForm(WidgetRef ref) {
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    final confirmPassword = ref.read(confirmPasswordProvider);
    final termsAccepted = ref.read(termsAcceptedProvider);
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

    if (confirmPassword.isEmpty) {
      errors['confirmPassword'] = 'Confirm password cannot be empty';
    } else if (password != confirmPassword) {
      errors['confirmPassword'] = 'Passwords do not match';
    }

    if (!termsAccepted) {
      errors['termsAccepted'] = 'You must accept the terms and conditions';
    }

    ref.read(formErrorProvider.notifier).state = errors;

    if (errors.isNotEmpty) {}
  }

  /// Invalidate provider
  void invalidateProviders(WidgetRef ref) {
    ref.invalidate(emailProvider);
    ref.invalidate(passwordProvider);
    ref.invalidate(confirmPasswordProvider);
    ref.invalidate(termsAcceptedProvider);
    ref.invalidate(showPasswordProvider);
    ref.invalidate(showConfirmPasswordProvider);
  }

  /// Show an error toast message with the provided error message
  void showError(String message) {
    utils.showToast(message, true, utils.checkPlatformIsIOS());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = InitRegistrationState();
    });
  }
}
