import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async
{
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'database.db');

  return await openDatabase(
      path, onCreate: (db, version)
  {
    //db.execute(PaisDao().createTableQuery);
    //db.execute(EstadoDao().createTableQuery);
  },
      version: 1
  );
}