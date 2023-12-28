import 'package:equatable/equatable.dart';

class CacheEntity extends Equatable{
  final int ? id;
  final int ? code;
  final String ? url;
  final String ? data;
  const CacheEntity({
    this.id,
    this.code,
    this.url,
    this.data
  });

  @override
  List < Object ? > get props {
    return [
      id,
      code,
      url,
      data
    ];
  }
}