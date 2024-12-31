import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_ga/core/database/app_db.dart';
import 'package:sembast/sembast.dart';

// Database provider
final databaseProvider = FutureProvider<Database>((ref) async {
  return await AppDataBase().database;
});
