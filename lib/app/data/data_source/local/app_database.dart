
import 'package:floor/floor.dart';
import 'package:github_repo_app/app/data/data_source/local/repo_dao.dart';
import 'package:github_repo_app/app/data/models/dio_cache.dart';


import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [CacheModel])
abstract class AppDatabase extends FloorDatabase {
  RepoDao get repoDao;
}