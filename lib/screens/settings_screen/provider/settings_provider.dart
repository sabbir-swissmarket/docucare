import 'package:docucare/custom_widgets/custom_button.dart';
import 'package:docucare/helper/enum_data.dart';
import 'package:docucare/routes/route_names.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/global_keys.dart';
import 'package:docucare/utils/shared_pref_keys.dart';
import 'package:docucare/utils/shared_pref_manager.dart';
import 'package:docucare/utils/utils.dart';

final settingsNotifierProvider =
    StateNotifierProvider<SettingsStateNotifier, SettingsState>(
        (ref) => SettingsStateNotifier());

@immutable
abstract class SettingsState {}

class InitSettingsState extends SettingsState {}

class LoadingSettingsState extends SettingsState {}

class LoadedSettingsState extends SettingsState {}

class ErrorSettingsState extends SettingsState {
  final String message;

  ErrorSettingsState({required this.message});
}

class SettingsStateNotifier extends StateNotifier<SettingsState> {
  SettingsStateNotifier() : super(InitSettingsState());
  final utils = locator.get<Utils>();
  final sharedPrefManager = locator.get<SharedPrefManager>();
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> signOut(BuildContext context) async {
    await supabase.auth.signOut().then((value) async {
      sharedPrefManager.logOut();
      await sharedPrefManager.saveEnumValue(
          SharedPrefKeys.showScreen, Screens.welcomeScreen);
      Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
          RoutesNames.welcomeScreen, (Route<dynamic> route) => false);
    });
  }

  Future<void> deleteAccount(BuildContext context) async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      await supabase.auth.admin.deleteUser(user.id).then((value) async {
        sharedPrefManager.logOut();
        await sharedPrefManager.saveEnumValue(
            SharedPrefKeys.showScreen, Screens.welcomeScreen);
        Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
            RoutesNames.welcomeScreen, (Route<dynamic> route) => false);
      });
    }
  }

  void showLogoutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sure you want to Logout?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    text: "No, cancel",
                    backgroundColor: AppColors.whiteColor,
                    borderColor: AppColors.primaryColor,
                    textColor: AppColors.primaryColor,
                    borderWidth: 2,
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    onPressed: () {
                      signOut(ctx);
                    },
                    text: "Yes, Logout",
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sure you want to Delete?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    text: "No, cancel",
                    backgroundColor: AppColors.whiteColor,
                    borderColor: AppColors.primaryColor,
                    textColor: AppColors.primaryColor,
                    borderWidth: 2,
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    onPressed: () {
                      deleteAccount(ctx);
                    },
                    text: "Yes, Delete",
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  /// Show an error toast message with the provided error message
  void showError(String message) {
    utils.showToast(message, true, utils.checkPlatformIsIOS());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = InitSettingsState();
    });
  }
}
