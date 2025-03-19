import 'package:docucare/helper/enum_data.dart';
import 'package:docucare/routes/route_names.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/global_keys.dart';
import 'package:docucare/utils/shared_pref_keys.dart';
import 'package:docucare/utils/shared_pref_manager.dart';
import 'package:docucare/utils/utils.dart';

final driveLoginNotifierProvider =
    StateNotifierProvider<DriveLoginStateNotifier, DriveLoginState>(
        (ref) => DriveLoginStateNotifier());

@immutable
abstract class DriveLoginState {}

class InitDriveLoginState extends DriveLoginState {}

class LoadingDriveLoginState extends DriveLoginState {}

class LoadedDriveLoginState extends DriveLoginState {}

class ErrorDriveLoginState extends DriveLoginState {
  final String message;

  ErrorDriveLoginState({required this.message});
}

class DriveLoginStateNotifier extends StateNotifier<DriveLoginState> {
  DriveLoginStateNotifier() : super(InitDriveLoginState());
  final utils = locator.get<Utils>();
  final sharePrefManager = locator.get<SharedPrefManager>();
  final supabase = Supabase.instance.client;
  final googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/drive.metadata.readonly',
    'https://www.googleapis.com/auth/drive.appdata',
    'https://www.googleapis.com/auth/userinfo.profile',
  ]);

  Future<void> loginWithGoogle() async {
    state = LoadingDriveLoginState();

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In was canceled');
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        throw Exception('Google Sign-In failed: Missing tokens');
      }

      // final response = await supabase.auth.signInWithIdToken(
      //   provider: OAuthProvider.google,
      //   idToken: idToken,
      //   accessToken: accessToken,
      // );

      // if (response.user != null) {
      await sharePrefManager.saveStringValue(
          SharedPrefKeys.googleAccessToken, accessToken);
      await sharePrefManager.saveEnumValue(
          SharedPrefKeys.showScreen, Screens.home);
      Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
          RoutesNames.home, (Route<dynamic> route) => false);
      // }
    } catch (error) {
      state = ErrorDriveLoginState(message: error.toString());
    }
  }

  /// Show an error toast message with the provided error message
  void showError(String message) {
    utils.showToast(message, true, utils.checkPlatformIsIOS());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = InitDriveLoginState();
    });
  }
}
