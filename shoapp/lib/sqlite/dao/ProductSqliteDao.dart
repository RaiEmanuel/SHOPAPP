/*import 'package:sqflite/sqlite_api.dart';
import 'package:shoapp/sqlite/database.dart';
import 'package:shoapp/model/ProductSqlite.dart';
import 'Dao.dart';

class ProductSqliteDao implements Dao<ProductSqlite>
{
  @override
  final tableName = 'ProductSqlite';

  @override
  final String _id = "0";
  final String _name = "product default";
  final String _description = "description default";
  final double _value = 0;
  final String _picture = "https://www.polibras.com.br/assets/images/products/0224.png";

  static ProductSqliteDao instance() {
    return ProductSqliteDao();
  }

  @override
  String get createTableQuery => "CREATE TABLE $tableName("
      " $id INTEGER PRIMARY KEY,"
      " $_name TEXT,"
      " $_description TEXT,"
      " $_description REAL,"
      " $_picture TEXT,";

  @override
  String get deleteAllRowsQuery => "DELETE FROM $tableName";

  @override
  Future<ProductSqlite> fromMap(Map<String, dynamic> query) async {
    Map<String, dynamic>? estadoJson = Map.of(query);
    //estadoJson[_id] = await PaisDao.instance().getObjMap(query[_paisId]);
    return Estado.fromJson(estadoJson);
  }

  @override
  Map<String, dynamic> toMap(Estado obj) {
    Map<String, dynamic> jsonMap = obj.toJson();
    jsonMap[_id] = obj.pais.id;
    return jsonMap;
  }

  @override
  Future<List<Estado>> fromList(List<Map<String, dynamic>> query) async {
    List<Estado> objList = [];
    for (Map<String, dynamic> map in query) {
      objList.add(await fromMap(map));
    }
    return objList;
  }

  @override
  Future<Estado?> getObj(String objId) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps =
    await db.query(tableName, where: '$id = ?', whereArgs: [objId]);
    if (maps.isNotEmpty) {
      return fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> getObjMap(String objId) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps =
    await db.query(tableName, where: '$id = ?', whereArgs: [objId]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

}*/