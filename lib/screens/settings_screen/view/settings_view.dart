import 'package:docucare/custom_widgets/custom_back_button.dart';
import 'package:docucare/custom_widgets/loader.dart';
import 'package:docucare/screens/settings_screen/provider/settings_provider.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:docucare/utils/core.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsProvider = ref.read(settingsNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            SettingsState state = ref.watch(settingsNotifierProvider);
            if (state is InitSettingsState) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomBackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Settings",
                          style: AppStyles.headline6,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            title: const Text(
                              "Delete Account",
                              style: AppStyles.bodyExtraLarge,
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: AppColors.iconColor,
                            ),
                            onTap: () {
                              settingsProvider.showDeleteDialog(context);
                            },
                          ),
                          Divider(color: Colors.grey.shade300),
                          ListTile(
                            title: const Text(
                              "Logout",
                              style: AppStyles.bodyExtraLarge,
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: AppColors.iconColor,
                            ),
                            onTap: () {
                              settingsProvider.showLogoutDialog(context);
                            },
                          ),
                          Divider(color: Colors.grey.shade300),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is LoadingSettingsState) {
              return const Center(child: Loader());
            } else if (state is ErrorSettingsState) {
              ref
                  .read(settingsNotifierProvider.notifier)
                  .showError(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
