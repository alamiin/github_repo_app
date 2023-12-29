import 'package:floor/floor.dart';

import 'base/dio_cache.dart';


@Entity(tableName: 'cache',primaryKeys: ['id'])
class CacheModel extends CacheEntity {
  const CacheModel({
    int ? id,
    int ? code,
    String ? url,
    String ? data,
  }): super(
    id: id,
    code: code,
      url: url,
    data: data
  );

  factory CacheModel.fromEntity(CacheEntity entity) {
    return CacheModel(
        id: entity.id,
        code: entity.code,
        url: entity.url,
        data: entity.data
    );
  }
}