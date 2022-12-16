import 'package:application_template/services/api/construct_string_endpoint.dart';
import 'package:application_template/services/interceptor/app_network.dart';
import 'package:application_template/services/interceptor/base_network.dart';
import 'package:dio/dio.dart';

abstract class BaseApi {
  AppNetwork? network;
  Response<dynamic>? response;

  BaseApi() {
    network = buildNetwork();
  }

  AppNetwork buildNetwork();

  fetchAll({Map<String, dynamic>? queryParameters}) async {
    var endPoint = urlEndPoint.fetchAllUrl();
    response = await network?.http?.get(endPoint, queryParameters: queryParameters);
    return response?.data;
  }

  fetchOne({required String id, Map<String, dynamic>? params}) async {
    var endPoint = '/${nameInUrl()}/$id';
    response = await network?.http?.get(endPoint, queryParameters: params);
    return response;
  }

  update({String? id, Map<String, dynamic>? body}) async {
    // TODO: add param in request url
    var endPoint = urlEndPoint.updateUrl(id: id);
    response = await network?.http?.put(endPoint, data: body);
    return response;
  }

  delete({String? id, Map<String, dynamic>? params}) async {
    var endpoint = urlEndPoint.deleteUrl(id: id);
    response = await network?.http?.delete(endpoint, data: params);

    return response;
  }

  create({required Map<String, dynamic> body, Map<String, dynamic>? options}) async {
    var endPoint = urlEndPoint.createUrl();
    response = await network?.http?.post(endPoint, data: body);
    return response?.data;
  }

  String nameInUrl();
  String path();
  ConstructStringEndPoint get urlEndPoint {
    return ConstructStringEndPoint(nameInUrl: nameInUrl(), path: path());
  }
}
