
import 'package:floor/floor.dart';
import 'package:github_repo_app/data/data_source/local/repo_dao.dart';
import 'package:github_repo_app/data/models/repo.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [RepoModel])
abstract class AppDatabase extends FloorDatabase {
  RepoDao get repoDao;
}