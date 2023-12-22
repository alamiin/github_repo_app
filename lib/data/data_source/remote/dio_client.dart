import 'dart:io';

import 'package:dio/dio.dart';


class DioClient {
  final String baseUrl;

  final Dio dio;
  DioClient({required this.baseUrl, required this.dio}) {
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 3000
      ..options.receiveTimeout = 3000
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
  }

  Future<Response> get( {required String uri, required Map<String, dynamic> queryParameters,}) async {
    var response = await dio.get(
        uri,
        queryParameters: queryParameters
    );
    return response;
  }

}
