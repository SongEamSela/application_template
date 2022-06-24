import 'package:dio/dio.dart';

class DefaultInterceptor extends InterceptorsWrapper {
  String baseUrl;
  DefaultInterceptor({required this.baseUrl});
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.baseUrl = baseUrl;
    super.onRequest(options, handler);
  }
}
