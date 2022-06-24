import 'package:application_template/services/interceptor/base_network.dart';
import 'package:dio/dio.dart';

abstract class BaseApi {
  BaseNetwork? network;
  Response<dynamic>? response;

  BaseApi() {
    network = BaseNetwork(baseUrl: 'https://reqres.in/api');
  }

  fetchAll({Map<String, dynamic>? queryParameters}) async {
    var endPoint = '/${nameInUrl()}';
    response = await network?.http?.get(endPoint, queryParameters: queryParameters);
    return response;
  }

  fetchOne({required String id, Map<String, dynamic>? params}) async {
    var endPoint = '/${nameInUrl()}/$id';
    response = await network?.http?.get(endPoint, queryParameters: params);
    return response;
  }

  update({String? id, Map<String, dynamic>? body}) async {
    // TODO: add param in request url
    var endPoint = '/${nameInUrl()}/$id';
    response = await network?.http?.put(endPoint, data: body);
    return response;
  }

  delete({String? id, Map<String, dynamic>? params}) async {
    var endpoint = '/${nameInUrl()}/$id';
    response = await network?.http?.delete(endpoint, data: params);
    return response;
  }

  create({required Map<String, dynamic> body, Map<String, dynamic>? options}) async {
    var endPoint = '/${nameInUrl()}';
    response = await network?.http?.post(endPoint, data: body);
    return response;
  }

  String nameInUrl();
}
