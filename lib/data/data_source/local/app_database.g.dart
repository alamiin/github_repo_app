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
            'CREATE TABLE IF NOT EXISTS `cache` (`id` INTEGER, `code` INTEGER, `url` TEXT, `data` TEXT, PRIMARY KEY (`id`))');

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
        _cacheModelInsertionAdapter = InsertionAdapter(
            database,
            'cache',
            (CacheModel item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'url': item.url,
                  'data': item.data
                }),
        _cacheModelUpdateAdapter = UpdateAdapter(
            database,
            'cache',
            ['id'],
            (CacheModel item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'url': item.url,
                  'data': item.data
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CacheModel> _cacheModelInsertionAdapter;

  final UpdateAdapter<CacheModel> _cacheModelUpdateAdapter;

  @override
  Future<CacheModel?> getCache(String url) async {
    return _queryAdapter.query('SELECT * FROM cache WHERE url = ?1',
        mapper: (Map<String, Object?> row) => CacheModel(
            id: row['id'] as int?,
            code: row['code'] as int?,
            url: row['url'] as String?,
            data: row['data'] as String?),
        arguments: [url]);
  }

  @override
  Future<void> insertCache(CacheModel cacheModel) async {
    await _cacheModelInsertionAdapter.insert(
        cacheModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCache(CacheModel cacheModel) async {
    await _cacheModelUpdateAdapter.update(cacheModel, OnConflictStrategy.abort);
  }
}
