import 'package:docucare/api_services/google_signin_api_service.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/shared_pref_keys.dart';
import 'package:docucare/utils/shared_pref_manager.dart';
import 'package:docucare/utils/utils.dart';
import 'package:googleapis/drive/v3.dart';

final fileListProvider = StateProvider<List<String>>((ref) => []);
final folderIdProvider = StateProvider<String>((ref) => "");

final folderViewNotifierProvider =
    StateNotifierProvider<FolderViewStateNotifier, FolderViewState>(
        (ref) => FolderViewStateNotifier());

@immutable
abstract class FolderViewState {}

class InitFolderViewState extends FolderViewState {}

class LoadingFolderViewState extends FolderViewState {}

class LoadedFolderViewState extends FolderViewState {}

class ErrorFolderViewState extends FolderViewState {
  final String message;

  ErrorFolderViewState({required this.message});
}

class FolderViewStateNotifier extends StateNotifier<FolderViewState> {
  FolderViewStateNotifier() : super(InitFolderViewState());
  final utils = locator.get<Utils>();
  final apiService = locator.get<GoogleSigninApiService>();
  final sharedPrefManager = locator.get<SharedPrefManager>();
  final googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/drive.file',
    'https://www.googleapis.com/auth/drive.metadata.readonly',
  ]);

  Future<void> fetchUploadedFiles(WidgetRef ref, String folderId) async {
    try {
      state = LoadingFolderViewState();
      final accesstoken = await sharedPrefManager
          .getStringValue(SharedPrefKeys.googleAccessToken);
      if (accesstoken == null) throw Exception("Access token is null");

      final authClient = await apiService.authenticateWithGoogle(accesstoken);

      final driveApi = DriveApi(authClient);
      final files = await driveApi.files.list(
        q: "'$folderId' in parents",
      );

      final uploadedFiles =
          files.files?.map((file) => file.name!).toList() ?? [];
      ref.read(fileListProvider.notifier).update((state) => uploadedFiles);
      state = LoadedFolderViewState();
    } catch (error) {
      state = ErrorFolderViewState(message: error.toString());
    }
  }

  /// Show an error toast message with the provided error message
  void showError(String message) {
    utils.showToast(message, true, utils.checkPlatformIsIOS());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = LoadedFolderViewState();
    });
  }
}
