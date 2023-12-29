
import 'package:github_repo_app/app/data/models/repo.dart';

class RepoResponse{
  int? totalCount;
  bool? incompleteResults;
  List<RepoModel>? items = [];

  RepoResponse({
    this.totalCount,
    this.incompleteResults,
    this.items
  });

  RepoResponse.fromJson(dynamic json, int pageNo) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(RepoModel.fromJson(v, pageNo));
      });
    }
  }

}