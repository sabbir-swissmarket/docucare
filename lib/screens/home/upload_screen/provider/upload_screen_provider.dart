import 'package:docucare/api_services/google_signin_api_service.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/global_keys.dart';
import 'package:docucare/utils/shared_pref_keys.dart';
import 'package:docucare/utils/shared_pref_manager.dart';
import 'package:docucare/utils/utils.dart';
import 'package:googleapis/drive/v3.dart' as drive;

final uploadScreenNotifierProvider =
    StateNotifierProvider<UploadScreenStateNotifier, UploadScreenState>(
        (ref) => UploadScreenStateNotifier());

@immutable
abstract class UploadScreenState {}

class InitUploadScreenState extends UploadScreenState {}

class LoadingUploadScreenState extends UploadScreenState {}

class LoadedUploadScreenState extends UploadScreenState {}

class ErrorUploadScreenState extends UploadScreenState {
  final String message;

  ErrorUploadScreenState({required this.message});
}

class UploadScreenStateNotifier extends StateNotifier<UploadScreenState> {
  UploadScreenStateNotifier() : super(InitUploadScreenState());
  final utils = locator.get<Utils>();
  final sharedPrefManager = locator.get<SharedPrefManager>();
  final apiService = locator.get<GoogleSigninApiService>();
  final googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/drive.file',
    'https://www.googleapis.com/auth/drive.metadata.readonly',
  ]);
  List<String> uploadedFiles = [];
  String folderId = "";

  Future<void> uploadFile() async {
    try {
      state = LoadingUploadScreenState();

      final accesstoken = await sharedPrefManager
          .getStringValue(SharedPrefKeys.googleAccessToken);

      if (accesstoken == null) throw Exception("Access token is null");

      final authClient = await apiService.authenticateWithGoogle(accesstoken);

      // Pick a file
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;

      final file = result.files.single;
      final fileBytes = file.bytes;
      final fileName = file.name;

      // Upload the file to the specified folder in Google Drive
      final driveApi = drive.DriveApi(authClient);
      final media = drive.Media(Stream.value(fileBytes!), fileBytes.length);
      final fileMetadata = drive.File()
        ..name = fileName
        ..parents = [folderId];

      final uploadedFile = await driveApi.files.create(
        fileMetadata,
        uploadMedia: media,
      );

      // Update the list of uploaded files
      uploadedFiles.add(uploadedFile.name!);

      utils.showToast(
          'File uploaded successfully', false, utils.checkPlatformIsIOS());
      Navigator.pop(navigatorKey.currentContext!, "dataUpdated");
    } catch (error) {
      state = ErrorUploadScreenState(message: error.toString());
    }
  }

  /// Show an error toast message with the provided error message
  void showError(String message) {
    utils.showToast(message, true, utils.checkPlatformIsIOS());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = InitUploadScreenState();
    });
  }
}
