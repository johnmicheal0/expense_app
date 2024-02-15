import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLDatabase {
  Database? database;

  Future<Database> get db async {
    if (database != null) {
      return database!;
    } else {
      final database = await initDatabase();
      return database;
    }
  }

  initDatabase() async {
    final path = join(await getDatabasesPath(), 'expense_db');
    return openDatabase(path, onCreate: tables, version: 1);
  }

  void tables(Database db, int version) async {
    db.execute(
        "CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,product VARCHAR(50) NOT NULL,price FLOAT NOT NULL,date VARCHAR(70),location VARCHAR(50) NOT NULL)");
  }
}
