import 'package:application_template/services/api/base_api.dart';
import 'package:application_template/services/interceptor/app_network.dart';

abstract class BaseToDoAPI extends BaseApi {
  @override
  AppNetwork buildNetwork() {
    return AppNetwork(baseUrl: 'http://127.0.0.1:8000');
  }

  @override
  String path() {
    return '/api';
  }
}
