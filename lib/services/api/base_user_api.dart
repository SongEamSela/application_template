import 'package:application_template/services/api/base_api.dart';
import 'package:application_template/services/interceptor/app_network.dart';

abstract class BaseUserApi extends BaseApi {
  @override
  AppNetwork buildNetwork() {
    return AppNetwork(baseUrl: 'https://reqres.in/api');
  }

  @override
  String path() {
    return '/user';
  }
}
