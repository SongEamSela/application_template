import 'package:application_template/storage/login_token_storage.dart';

class SignInCheckerService {
  static Future<bool> call() async {
    var loginStorage = LoginTokenStorage();
    var accessToken = await loginStorage.getString();
    return accessToken != null;
  }
}
