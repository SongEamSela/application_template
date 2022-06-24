import 'package:application_template/services/api/base_api.dart';

class UserApi extends BaseApi {
  @override
  String nameInUrl() {
    return 'users';
  }
}
