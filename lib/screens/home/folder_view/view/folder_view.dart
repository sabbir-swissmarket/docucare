import 'package:docucare/custom_widgets/custom_back_button.dart';
import 'package:docucare/custom_widgets/loader.dart';
import 'package:docucare/routes/route_names.dart';
import 'package:docucare/screens/home/folder_view/provider/folder_view_provider.dart';
import 'package:docucare/screens/home/models/folder_model.dart';
import 'package:docucare/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FolderViewScreen extends ConsumerStatefulWidget {
  const FolderViewScreen({super.key});

  @override
  ConsumerState<FolderViewScreen> createState() => _FolderViewScreenState();
}

class _FolderViewScreenState extends ConsumerState<FolderViewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(folderViewNotifierProvider.notifier)
          .fetchUploadedFiles(ref, ref.read(folderIdProvider.notifier).state);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as FolderModel;
    final fileLists = ref.watch(fileListProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            FolderViewState state = ref.watch(folderViewNotifierProvider);
            if (state is InitFolderViewState) {
              return const SizedBox.shrink();
            } else if (state is LoadingFolderViewState) {
              return const Center(child: Loader());
            } else if (state is LoadedFolderViewState) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomBackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.upload,
                              color: AppColors.primaryColor),
                          iconSize: 32,
                          onPressed: () async {
                            final data = await Navigator.pushNamed(
                                context, RoutesNames.uploadDocumentScreen,
                                arguments: args);
                            if (data.toString() == "dataUpdated") {
                              ref
                                  .read(folderViewNotifierProvider.notifier)
                                  .fetchUploadedFiles(ref, args.id);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      args.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    fileLists.isEmpty
                        ? const Center(child: Text("No files available"))
                        : Expanded(
                            child: ListView.builder(
                              itemCount: fileLists.length,
                              itemBuilder: (context, index) {
                                return Text(fileLists[index]);
                              },
                            ),
                          ),
                  ],
                ),
              );
            } else if (state is ErrorFolderViewState) {
              ref
                  .read(folderViewNotifierProvider.notifier)
                  .showError(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
