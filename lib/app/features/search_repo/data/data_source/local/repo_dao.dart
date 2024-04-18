import 'package:floor/floor.dart';
import 'package:github_repo_app/app/features/search_repo/data/model/dio_cache.dart';
import 'package:github_repo_app/app/features/search_repo/data/model/repo.dart';



@dao
abstract class RepoDao {

  @Insert()
  Future<void> insertRepository(RepoModel repoModel);

  @Query('SELECT * FROM repo WHERE pageKey = :key')
  Future<RepoModel?> getRepository(String key);

  @update
  Future<void> updateRepository(RepoModel repoModel);

  @Insert()
  Future<void> insertCache(CacheModel cacheModel);

  @Query('SELECT * FROM cache WHERE url = :url')
  Future<CacheModel?> getCache(String url);

  @update
  Future<void> updateCache(CacheModel cacheModel);

}