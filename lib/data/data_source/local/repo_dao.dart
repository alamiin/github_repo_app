import 'package:floor/floor.dart';
import 'package:github_repo_app/data/models/repo.dart';

@dao
abstract class RepoDao {
  
  @Insert()
  Future<void> insertRepo(RepoModel repo);

  @Query('SELECT * FROM repo')
  Future<List<RepoModel>> getAllRepo();

  @Query('SELECT * FROM repo WHERE id = :id')
  Future<RepoModel?> getRepo(int id);

  @update
  Future<void> updateRepo(RepoModel repo);

}