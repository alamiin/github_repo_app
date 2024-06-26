import 'package:equatable/equatable.dart';

class RepoEntity extends Equatable{
  final int ? id;
  final String ? pageKey;
  final String ? name;
  final String ? repoName;
  final String ? avatarUrl;
  final String ? description;
  final int ? stars;
  final String ? updatedAt;

  const RepoEntity({
    this.id,
    this.pageKey,
    this.name,
    this.repoName,
    this.avatarUrl,
    this.description,
    this.stars,
    this.updatedAt,
  });

  @override
  List < Object ? > get props {
    return [
      id,
      pageKey,
      name,
      repoName,
      avatarUrl,
      description,
      stars,
      updatedAt
    ];
  }
}