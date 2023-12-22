


import 'package:github_repo_app/core/resources/data_state.dart';
import 'package:github_repo_app/data/models/base/repo.dart';
import 'package:github_repo_app/data/models/repo.dart';
import 'package:github_repo_app/data/models/repo_response.dart';

abstract class RepoRepository {
  // API methods
  Future<DataState<RepoResponse>> getGithubRepo(int pageNo);

  // Database methods
  Future < List < RepoModel >> getSavedRepo();

  Future < void > saveRepo(RepoEntity repoEntity);

  // Future < void > removeArticle(RepoEntity repoEntity);
}