// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RepoDao? _repoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `repo` (`id` INTEGER, `pageNo` INTEGER, `name` TEXT, `repoName` TEXT, `avatarUrl` TEXT, `description` TEXT, `stars` INTEGER, `updatedAt` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RepoDao get repoDao {
    return _repoDaoInstance ??= _$RepoDao(database, changeListener);
  }
}

class _$RepoDao extends RepoDao {
  _$RepoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _repoModelInsertionAdapter = InsertionAdapter(
            database,
            'repo',
            (RepoModel item) => <String, Object?>{
                  'id': item.id,
                  'pageNo': item.pageNo,
                  'name': item.name,
                  'repoName': item.repoName,
                  'avatarUrl': item.avatarUrl,
                  'description': item.description,
                  'stars': item.stars,
                  'updatedAt': item.updatedAt
                }),
        _repoModelUpdateAdapter = UpdateAdapter(
            database,
            'repo',
            ['id'],
            (RepoModel item) => <String, Object?>{
                  'id': item.id,
                  'pageNo': item.pageNo,
                  'name': item.name,
                  'repoName': item.repoName,
                  'avatarUrl': item.avatarUrl,
                  'description': item.description,
                  'stars': item.stars,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RepoModel> _repoModelInsertionAdapter;

  final UpdateAdapter<RepoModel> _repoModelUpdateAdapter;

  @override
  Future<List<RepoModel>> getAllRepo() async {
    return _queryAdapter.queryList('SELECT * FROM repo',
        mapper: (Map<String, Object?> row) => RepoModel(
            id: row['id'] as int?,
            pageNo: row['pageNo'] as int?,
            name: row['name'] as String?,
            repoName: row['repoName'] as String?,
            avatarUrl: row['avatarUrl'] as String?,
            description: row['description'] as String?,
            stars: row['stars'] as int?,
            updatedAt: row['updatedAt'] as String?));
  }

  @override
  Future<RepoModel?> getRepo(int id) async {
    return _queryAdapter.query('SELECT * FROM repo WHERE id = ?1',
        mapper: (Map<String, Object?> row) => RepoModel(
            id: row['id'] as int?,
            pageNo: row['pageNo'] as int?,
            name: row['name'] as String?,
            repoName: row['repoName'] as String?,
            avatarUrl: row['avatarUrl'] as String?,
            description: row['description'] as String?,
            stars: row['stars'] as int?,
            updatedAt: row['updatedAt'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertRepo(RepoModel repo) async {
    await _repoModelInsertionAdapter.insert(repo, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRepo(RepoModel repo) async {
    await _repoModelUpdateAdapter.update(repo, OnConflictStrategy.abort);
  }
}
