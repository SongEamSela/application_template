import 'package:application_template/services/interceptor/default_interceptor.dart';
import 'package:application_template/services/interceptor/error_interceptor.dart';
import 'package:dio/dio.dart';

class BaseNetwork {
  Dio? http;
  String? baseUrl;

  BaseNetwork({required this.baseUrl}) {
    http = Dio();
    http?.interceptors.add(DefaultInterceptor(baseUrl: baseUrl ?? ""));
    http?.interceptors.add(ErrorInterceptors());
  }

  addInterceptor(InterceptorsWrapper interceptor) {
    http?.interceptors.add(interceptor);
  }

  removeInterceptor(InterceptorsWrapper interceptor) {
    http?.interceptors.remove(interceptor);
  }
}
