import 'package:application_template/services/interceptor/base_network.dart';
import 'package:application_template/services/interceptor/error_interceptor.dart';
import 'package:dio_logger/dio_logger.dart';

class AppNetwork extends BaseNetwork {
  AppNetwork({required String? baseUrl}) : super(baseUrl: baseUrl) {
    addInterceptor(ErrorInterceptors());
    addInterceptor(dioLoggerInterceptor);
  }
}
