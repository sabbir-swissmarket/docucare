import 'package:docucare/api_services/google_signin_api_service.dart';
import 'package:docucare/screens/home/models/folder_model.dart';
import 'package:docucare/utils/core.dart';
import 'package:docucare/utils/shared_pref_keys.dart';
import 'package:docucare/utils/shared_pref_manager.dart';
import 'package:docucare/utils/utils.dart';
import 'package:googleapis/people/v1.dart' as people;
import 'package:googleapis/drive/v3.dart' as drive;

final userNameProvider = StateProvider<String>((ref) => '');
final storageQuotaProvder = StateProvider<String>((ref) => '');
final folderListProvider = StateProvider<List<FolderModel>>((ref) => []);

final homeNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, HomeState>(
        (ref) => HomeStateNotifier());

@immutable
abstract class HomeState {}

class InitHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {}

class ErrorHomeState extends HomeState {
  final String message;

  ErrorHomeState({required this.message});
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(InitHomeState());
  final utils = locator.get<Utils>();
  final apiService = locator.get<GoogleSigninApiService>();
  final sharedPrefManager = locator.get<SharedPrefManager>();
  final googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/drive.metadata.readonly',
    'https://www.googleapis.com/auth/drive.appdata',
    'https://www.googleapis.com/auth/userinfo.profile',
  ]);

  Future<void> loadData(WidgetRef ref) async {
    try {
      state = LoadingHomeState();
      final accesstoken = await sharedPrefManager
          .getStringValue(SharedPrefKeys.googleAccessToken);
      await signInAndFetchData(ref, accesstoken!);
      state = LoadedHomeState();
    } catch (e) {
      debugPrint(e.toString());
      state = ErrorHomeState(message: e.toString());
    }
  }

  Future<void> signInAndFetchData(WidgetRef ref, String? accessToken) async {
    try {
      if (accessToken == null) throw Exception("Access token is null");

      final authClient = await apiService.authenticateWithGoogle(accessToken);

      final peopleApi = people.PeopleServiceApi(authClient);
      final profile =
          await peopleApi.people.get('people/me', personFields: 'names');
      final profileName = profile.names?.first.displayName ?? 'Unknown';
      ref.read(userNameProvider.notifier).update((state) => profileName);

      final driveApi = drive.DriveApi(authClient);
      final about = await driveApi.about.get($fields: 'storageQuota');
      final usageGB =
          utils.bytesToGB(int.tryParse(about.storageQuota?.usage ?? '0') ?? 0);
      final limitGB =
          utils.bytesToGB(int.tryParse(about.storageQuota?.limit ?? '0') ?? 0);
      final storageQuota = '$usageGB / $limitGB';
      ref.read(storageQuotaProvder.notifier).update((state) => storageQuota);

      final folderResponse = await driveApi.files.list(
        q: "mimeType='application/vnd.google-apps.folder'",
        $fields: 'files(id, name, createdTime)',
      );

      if (folderResponse.files == null) {
        ref.read(folderListProvider.notifier).update((state) => []);
        return;
      }

      List<Future<FolderModel>> folderFutures =
          folderResponse.files!.map((folder) async {
        final filesResponse = await driveApi.files.list(
          q: "'${folder.id}' in parents",
        );
        final files = filesResponse.files
                ?.map((file) => file.name ?? 'Unnamed File')
                .toList() ??
            [];
        return FolderModel(
          id: folder.id ?? "",
          name: folder.name ?? 'Unnamed Folder',
          createdTime: folder.createdTime.toString(),
          files: files,
        );
      }).toList();

      final folders = await Future.wait(folderFutures);
      ref.read(folderListProvider.notifier).update((state) => folders);
    } catch (e, stackTrace) {
      debugPrint("Error in signInAndFetchData: $e\n$stackTrace");
      if (e
          .toString()
          .toLowerCase()
          .contains("Access was denied".toLowerCase())) {
        await getAccessToken(ref);
      } else {
        state = ErrorHomeState(message: e.toString());
      }
    }
  }

  Future<void> getAccessToken(WidgetRef ref) async {
    try {
      state = LoadingHomeState();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In was canceled');
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        state = LoadedHomeState();
        throw Exception('Google Sign-In failed: Missing tokens');
      } else {
        await sharedPrefManager.saveStringValue(
            SharedPrefKeys.googleAccessToken, accessToken);
        await loadData(ref);
      }
    } catch (e) {
      state = ErrorHomeState(message: e.toString());
    }
  }

  String getDateTime(String date) {
    if (date.isNotEmpty) {
      return utils.formatDate(date);
    } else {
      return "";
    }
  }

  /// Show an error toast message with the provided error message
  void showError(String message) {
    utils.showToast(message, true, utils.checkPlatformIsIOS());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = LoadedHomeState();
    });
  }
}
