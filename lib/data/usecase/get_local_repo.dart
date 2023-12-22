

import 'package:github_repo_app/core/resources/data_state.dart';
import 'package:github_repo_app/core/usecase/usecase.dart';
import 'package:github_repo_app/data/models/base/repo.dart';
import 'package:github_repo_app/data/models/repo.dart';
import 'package:github_repo_app/data/models/repo_response.dart';
import 'package:github_repo_app/data/repository/base/repo_repository.dart';

class GetSavedRepoUseCase implements UseCase<List<RepoEntity>,void>{
  
  final RepoRepository _repoRepository;

  GetSavedRepoUseCase(this._repoRepository);
  
  @override
  Future<List<RepoModel>> call({ void params }) {
    return _repoRepository.getSavedRepo();
  }

  
}