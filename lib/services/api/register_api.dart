import 'package:application_template/services/api/base_user_api.dart';

class RegisterApi extends BaseUserApi {
  @override
  String nameInUrl() {
    return 'register';
  }
}
