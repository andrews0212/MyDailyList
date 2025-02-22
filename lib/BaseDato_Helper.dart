import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseDato_Helper{
  Future<Database> _openDataBase() async{

    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, "tareas.db");

    return openDatabase(
      path,
      onCreate: (db, version) async{
        await db.execute("""CREATE TABLE Tareas (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              titulo TEXT NOT NULL,
              descripcion TEXT,
              fecha_limite INTEGER NOT NULL,
              categoria TEXT NOT NULL,
              prioridad TEXT NOT NULL
          )"""
        );

    }, version: 1
    );
  }

  Future<int> add(Map<String, dynamic> tarea) async{
    final db = await _openDataBase();
    return await db.insert("Tareas", tarea);
  }

  Future<int> update(Map<String, dynamic> tarea) async{
    final db = await _openDataBase();
    return await db.update("Tareas", tarea, where: "id = ?", whereArgs: [tarea["id"]]);
  }

  Future<Map<String, dynamic>?> find(int id) async{
    final db = await _openDataBase();
    final result = await db.query("Tareas", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> findAll() async{
    final db = await _openDataBase();
    return await db.query("Tareas");
  }

  Future<int> delete(int id) async{
    final db = await _openDataBase();
    return await db.delete("Tareas", where: "id = ?", whereArgs: [id]);
  }





}