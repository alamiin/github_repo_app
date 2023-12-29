import 'package:equatable/equatable.dart';

class RepoEntity extends Equatable{
  final int ? id;
  final int ? pageNo;
  final String ? name;
  final String ? repoName;
  final String ? avatarUrl;
  final String ? description;
  final int ? stars;
  final String ? updatedAt;

  const RepoEntity({
    this.id,
    this.pageNo,
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
      pageNo,
      name,
      repoName,
      avatarUrl,
      description,
      stars,
      updatedAt
    ];
  }
}