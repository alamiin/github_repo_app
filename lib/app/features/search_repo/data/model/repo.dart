import 'package:floor/floor.dart';
import 'package:github_repo_app/app/features/search_repo/domain/entity/repo.dart';
import 'package:intl/intl.dart';



@Entity(tableName: 'repo',primaryKeys: ['id'])
class RepoModel extends RepoEntity {
  const RepoModel({
    int ? id,
    String ? pageKey,
    String ? name,
    String ? repoName,
    String ? avatarUrl,
    String ? description,
    int ? stars,
    String ? updatedAt,
  }): super(
    id: id,
    pageKey: pageKey,
    name: name,
    repoName: repoName,
    avatarUrl: avatarUrl,
    description: description,
    stars: stars,
    updatedAt: updatedAt,
  );

  /// here we added a pageKey for updating and pagination data

  factory RepoModel.fromJson(Map < String, dynamic > map, int pageNo, int index) {

    DateTime dateTime = DateTime.parse(map['updated_at'] ?? "").toLocal();
    // final difference = date2.difference(dateTime);
    final dt = DateFormat('MM-dd-yyyy hh:mm:s a').format(dateTime);

    return RepoModel(
      id: map['id'] ?? -1,
      pageKey: "page No: ${pageNo} index No:  ${index}",
      name: map['owner']["login"] ?? "",
      repoName: map['name'] ?? "",
      avatarUrl: map['owner']["avatar_url"] ?? "",
      description: map['description'] ?? "",
      stars: map['stargazers_count'] ?? "",
      updatedAt: dt,
    );
  }

  factory RepoModel.fromEntity(RepoEntity entity) {
    return RepoModel(
        id: entity.id,
        pageKey: entity.pageKey,
        name: entity.name,
        repoName: entity.repoName,
        avatarUrl: entity.avatarUrl,
        description: entity.description,
        stars: entity.stars,
        updatedAt: entity.updatedAt
    );
  }
}