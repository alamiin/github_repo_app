

import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../models/repo_response.dart';
import '../repository/base/repo_repository.dart';

class GetRepoUseCase implements UseCase<DataState<RepoResponse>,int>{
  
  final RepoRepository _repoRepository;

  GetRepoUseCase(this._repoRepository);
  
  @override
  Future<DataState<RepoResponse>> call({ int params = 1}) {
    return _repoRepository.getGithubRepo(params);
  }
  
}