import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github_repo_app/app/core/constants/constants.dart';
import 'package:github_repo_app/app/core/resources/data_state.dart';
import 'package:github_repo_app/app/data/data_source/remote/dio_client.dart';
import 'package:github_repo_app/app/data/models/repo_response.dart';


import 'base/repo_repository.dart';


class RepoRepositoryImpl implements RepoRepository {

  final DioClient _dioClient;
  RepoRepositoryImpl(this._dioClient);

  @override
  Future<DataState<RepoResponse>> getGithubRepo(int pageNo) async {
   try {
      final queryParameter = {
        query: queryKey,
        perPage: perPageKey,
        page: "$pageNo"
      };
     final httpResponse = await _dioClient.get(
      uri: searchRepo,
      queryParameters: queryParameter
    );

    if (httpResponse.statusCode == HttpStatus.ok) {
      final successRepoData = RepoResponse.fromJson(httpResponse.data, pageNo);
      return DataSuccess(successRepoData);
    } else {
      return DataFailed(
          DioException(
          error: httpResponse.statusMessage,
          response: httpResponse,
          type: DioExceptionType.unknown,
          requestOptions: httpResponse.requestOptions
        )
      );
    }
   } on DioException catch(e){
    return DataFailed(e);
   }
  }

}