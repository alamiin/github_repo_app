
import 'package:github_repo_app/app/core/resources/data_state.dart';
import 'package:github_repo_app/app/features/search_repo/data/model/repo_response.dart';

abstract class RepoRepository {
  // API methods
  Future<DataState<RepoResponse>> getGithubRepo(int pageNo);

  // // Database methods
  // Future < List < RepoModel >> getSavedRepo();
  //
  // Future < void > saveRepo(RepoEntity repoEntity);

  // Future < void > removeArticle(RepoEntity repoEntity);
}