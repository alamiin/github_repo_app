import 'package:floor/floor.dart';
import 'package:github_repo_app/data/models/repo.dart';

import '../../models/dio_cache.dart';

@dao
abstract class RepoDao {
  @Insert()
  Future<void> insertCache(CacheModel cacheModel);

  @Query('SELECT * FROM cache WHERE url = :url')
  Future<CacheModel?> getCache(String url);

  @update
  Future<void> updateCache(CacheModel cacheModel);

}