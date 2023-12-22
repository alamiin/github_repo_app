
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_repo_app/data/data_source/local/app_database.dart';
import 'package:github_repo_app/data/data_source/remote/dio_client.dart';
import 'package:github_repo_app/data/repository/article_repository_impl.dart';
import 'package:github_repo_app/data/repository/base/repo_repository.dart';
import 'package:github_repo_app/data/usecase/get_local_repo.dart';
import 'package:github_repo_app/data/usecase/get_repo.dart';
import 'package:github_repo_app/provider/repo_provider.dart';

import 'core/constants/constants.dart';


final sl = GetIt.instance;

Future<void> init() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  //base
  sl.registerSingleton<Dio>(Dio());
  sl.registerLazySingleton(() => DioClient(dio: sl(), baseUrl: githubAPIBaseURL));

  // Dependencies
  sl.registerSingleton<RepoRepository>(
      RepoRepositoryImpl(sl(),sl())
  );

  //UseCases
  sl.registerSingleton<GetRepoUseCase>(
      GetRepoUseCase(sl())
  );
  sl.registerSingleton<GetSavedRepoUseCase>(
      GetSavedRepoUseCase(sl())
  );

  // Provider
  sl.registerFactory(() => RepoProvider(
      getRepoUseCase: sl(),
    getSavedRepoUseCase: sl()
  ));

}
