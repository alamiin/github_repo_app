

import 'package:github_repo_app/core/resources/data_state.dart';
import 'package:github_repo_app/core/usecase/usecase.dart';
import 'package:github_repo_app/data/models/base/repo.dart';
import 'package:github_repo_app/data/models/repo_response.dart';
import 'package:github_repo_app/data/repository/base/repo_repository.dart';

class GetRepoUseCase implements UseCase<DataState<RepoResponse>,int>{
  
  final RepoRepository _repoRepository;

  GetRepoUseCase(this._repoRepository);
  
  @override
  Future<DataState<RepoResponse>> call({ int params = 1}) {
    return _repoRepository.getGithubRepo(params);
  }
  
}