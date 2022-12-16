import 'package:application_template/services/api/base_api.dart';
import 'package:application_template/services/api/base_user_api.dart';

class UserApi extends BaseUserApi {
  @override
  String nameInUrl() {
    return 'users';
  }
}
