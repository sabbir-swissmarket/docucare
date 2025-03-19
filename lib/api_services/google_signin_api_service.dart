import 'package:docucare/utils/core.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;

class GoogleSigninApiService {
  Future<auth.AuthClient> authenticateWithGoogle(String accessToken) async {
    final googleSignIn = GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/drive.metadata.readonly',
      'https://www.googleapis.com/auth/drive.appdata',
      'https://www.googleapis.com/auth/userinfo.profile',
    ]);
    final baseClient = http.Client();

    final credentials = auth.AccessCredentials(
      auth.AccessToken(
        'Bearer',
        accessToken,
        DateTime.now().add(const Duration(hours: 1)).toUtc(),
      ),
      null,
      googleSignIn.scopes,
    );

    final authClient = auth.authenticatedClient(baseClient, credentials);

    return authClient;
  }
}
