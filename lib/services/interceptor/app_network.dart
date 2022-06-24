import 'package:application_template/services/interceptor/base_network.dart';
import 'package:application_template/services/interceptor/error_interceptor.dart';

class AppNetwork extends BaseNetwork {
  AppNetwork({required String? baseUrl}) : super(baseUrl: baseUrl) {
    addInterceptor(ErrorInterceptors());
  }
}
