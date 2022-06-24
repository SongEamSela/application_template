import 'package:application_template/storage/base_string_storage.dart';

class LoginTokenStorage extends BaseStringStorage {
  @override
  String key() {
    return 'user_token';
  }
}
