import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github_repo_app/core/constants/constants.dart';
import 'package:github_repo_app/core/resources/data_state.dart';
import 'package:github_repo_app/data/data_source/local/app_database.dart';
import 'package:github_repo_app/data/data_source/remote/dio_client.dart';
import 'package:github_repo_app/data/models/base/repo.dart';
import 'package:github_repo_app/data/models/repo.dart';
import 'package:github_repo_app/data/models/repo_response.dart';

import 'base/repo_repository.dart';


class RepoRepositoryImpl implements RepoRepository {


  final DioClient _dioClient;
  final AppDatabase _appDatabase;
  RepoRepositoryImpl(this._dioClient, this._appDatabase);

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
      if(successRepoData.items!.isNotEmpty){
        successRepoData.items!.forEach((element) async {
          RepoModel? searchData = await _appDatabase.repoDao.getRepo(element.id!);
          if(searchData == null){
            await _appDatabase.repoDao.insertRepo(element);
          }else{
            await _appDatabase.repoDao.updateRepo(element);
          }
        });
      }
      return DataSuccess(successRepoData);
    } else {
      return DataFailed(
        DioError(
          error: httpResponse.statusMessage,
          response: httpResponse,
          type: DioErrorType.response,
          requestOptions: httpResponse.requestOptions
        )
      );
    }
   } on DioError catch(e){
    return DataFailed(e);
   }
  }

  @override
  Future<List<RepoModel>> getSavedRepo() async {
    return _appDatabase.repoDao.getAllRepo();
  }

  @override
  Future<void> saveRepo(RepoEntity repoEntity) {
    return _appDatabase.repoDao.insertRepo(RepoModel.fromEntity(repoEntity));
  }

}