
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_repo_app/app/features/search_repo/data/data_source/local/app_database.dart';
import 'package:github_repo_app/app/features/search_repo/data/data_source/remote/chach_interceptor.dart';
import 'package:github_repo_app/app/features/search_repo/data/data_source/remote/dio_client.dart';
import 'package:github_repo_app/app/features/search_repo/data/repository/article_repository_impl.dart';
import 'package:github_repo_app/app/features/search_repo/domain/repository/repo_repository.dart';
import 'package:github_repo_app/app/features/search_repo/domain/usecase/get_repo.dart';
import 'package:github_repo_app/app/features/search_repo/presentation/provider/repo_provider.dart';



final sl = GetIt.instance;

Future<void> init() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  //base
  sl.registerSingleton<Dio>(Dio());
  sl.registerLazySingleton(() => CacheInterceptor(appDatabase: sl()));
  sl.registerLazySingleton(() => DioClient(dio: sl(), cacheInterceptor: sl() ));

  // Dependencies
  sl.registerSingleton<RepoRepository>(
      RepoRepositoryImpl(sl())
  );

  //UseCases
  sl.registerSingleton<GetRepoUseCase>(
      GetRepoUseCase(sl())
  );


  // Provider
  sl.registerFactory(() => RepoProvider(
      getRepoUseCase: sl()
  ));

}
