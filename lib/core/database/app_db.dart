import 'dart:async';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

/// A singleton class that manages the Sembast database connection for the application.
///
/// This class provides a centralized way to access the application's database.
/// It implements the singleton pattern to ensure only one database connection
/// exists throughout the app's lifecycle.
class AppDataBase {
  /// The name of the database file.
  static const String databaseName = 'appDataBase.db';

  /// Singleton instance of [AppDataBase].
  static AppDataBase? _instance;

  /// The database instance.
  ///
  /// This is lazy-initialized when first  accessed through [database] getter.
  Database? _database;

  /// Private constructor to prevent direct instantiation.
  AppDataBase._();

  /// Factory constructor that returns the singleton instance of [AppDataBase].
  ///
  /// Create a new instance if one doesn't exist, otherwise returns the existing instance.
  ///
  /// Example:
  /// ``` dart
  /// final dbInstance = AppDataBase();
  /// ```
  factory AppDataBase() {
    return _instance ??= AppDataBase._();
  }

  /// Asuncgronously gets the database instance.
  ///
  /// If the databese hasn't been initialized, it will initiakize it first.
  /// Subsequent calls will return the same database instance.
  ///
  /// Reutns a [Future] that completes with the [Database] instance.
  ///
  /// Example:
  /// ``` dart
  /// final db = await AppDataBase().database;
  /// ```
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  /// Initializes the database.
  ///
  /// This method:
  /// 1. Gets the application dociments directory;
  /// 2. Constructs the database path;
  /// 3. Opens the database connection.
  ///
  /// Throws an [Exception] if database initialization fails.
  ///
  /// This is an internal method and shouldn't be called directly.
  Future<Database> _initDatabase() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final dbPath = join(dir.path, databaseName);
      final db = await databaseFactoryIo.openDatabase(dbPath);
      return db;
    } catch (e) {
      throw Exception('Failed to init database: $e');
    }
  }

  /// Closes the database connection.
  ///
  /// This method should be called when the database is no longer needed, such as when the
  /// application is about to be terminated or when the connection is no longer required.
  /// Calling this method will release any resources held by the database connection.
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
