
import 'package:dio/dio.dart';
import 'chach_interceptor.dart';


class DioClient {
  final String baseUrl;
  final Dio dio;
  final CacheInterceptor cacheInterceptor;
  DioClient( {required this.baseUrl, required this.dio, required this.cacheInterceptor}) {
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 3000)
      ..options.receiveTimeout = const Duration(milliseconds: 3000)
      ..httpClientAdapter
      ..interceptors.add(cacheInterceptor);
  }

  Future<Response> get( {required String uri, required Map<String, dynamic> queryParameters,}) async {
    var response = await dio.get(
        uri,
        queryParameters: queryParameters
    );
    return response;
  }

}
