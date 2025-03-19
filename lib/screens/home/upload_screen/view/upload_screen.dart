import 'package:docucare/custom_widgets/custom_back_button.dart';
import 'package:docucare/custom_widgets/custom_button.dart';
import 'package:docucare/screens/home/models/folder_model.dart';
import 'package:docucare/screens/home/upload_screen/provider/upload_screen_provider.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/screen_config.dart';

class UploadDocumentScreen extends ConsumerWidget {
  const UploadDocumentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as FolderModel;
    final width = locator.get<SizeConfig>().getFullWidth();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(uploadScreenNotifierProvider.notifier).folderId = args.id;
    });
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Consumer(
        builder: (context, ref, child) {
          UploadScreenState state = ref.watch(uploadScreenNotifierProvider);
          if (state is InitUploadScreenState ||
              state is LoadingUploadScreenState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 70, 24, 0),
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
                      SizedBox(
                        width: width * 0.7,
                        child: Text(
                          "${args.name}/Upload",
                          style: AppStyles.headline6,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Upload a Document",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Document Title",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      ref
                          .read(uploadScreenNotifierProvider.notifier)
                          .uploadFile();
                    },
                    child: Image.asset(
                      'assets/images/doc-file.png',
                      width: 250,
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Select File",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    onPressed: () {},
                    text: "Upload",
                    width: width,
                  ),
                ],
              ),
            );
          } else if (state is ErrorUploadScreenState) {
            ref
                .read(uploadScreenNotifierProvider.notifier)
                .showError(state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
