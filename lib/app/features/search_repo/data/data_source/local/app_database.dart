
import 'package:floor/floor.dart';
import 'package:github_repo_app/app/features/search_repo/data/data_source/local/repo_dao.dart';
import 'package:github_repo_app/app/features/search_repo/data/model/dio_cache.dart';
import 'package:github_repo_app/app/features/search_repo/data/model/repo.dart';


import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [RepoModel, CacheModel])
abstract class AppDatabase extends FloorDatabase {
  RepoDao get repoDao;
}