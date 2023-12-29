import 'package:dio/dio.dart';
import 'package:github_repo_app/app/data/data_source/local/app_database.dart';
import 'package:github_repo_app/app/helper/cache_response.dart';



class CacheInterceptor extends InterceptorsWrapper with CacheResponseMixin {

  final AppDatabase appDatabase;
  CacheInterceptor({ required  this.appDatabase});

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    await saveResponse(response, appDatabase);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown) {
      Response? response = await loadResponse(err, appDatabase);
      if (response != null) {
        handler.resolve(response);
        return;
      }
    }
    super.onError(err, handler);
  }

}
