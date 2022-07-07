import 'package:local_databse/model/note_model.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlHelper {
  static Future<Database> initDb() async {
    //storing the db in the device
    //in ANDROID /DATA

    final dbPath = await getDatabasesPath();

    //bestPractice
    final path = join(dbPath, 'notes.db');
    return openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await createtables(database);
    });
  }

  //create table
  static Future<void> createtables(Database database) async {
    await database.execute("""
           CREATE TABLE Notes (
             id INTEGER PRIMARY KEY AUTOINCREMENT,
             title TEXT ,
             description TEXT ,
             createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

  )
 """);
    Logger().i("SuccessFully Created  Database");
  }

//create new note
  static Future<void> createNote(
    String title,
    String desc,
  ) async {
    final db = await initDb();

    final data = {'title': title, 'description': desc};

    await db.insert('Notes', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    Logger().i("SuccessFully Saved To Database");
  }

  static Future<List<NoteModel>> getNotes() async {
    final db = await initDb();

    final result = await db.query('Notes', orderBy: "id");

    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  //Find note id
  static Future<NoteModel> getNoteById(int id) async {
    final db = await initDb();
    final result =
        await db.query('Notes', where: "id =?", whereArgs: [id], limit: 1);
    return NoteModel.fromMap(result.first);
  }

//update Note
  static Future<int> updateNote(
    int id,
    String title,
    String? desc,
  ) async {
    final db = await initDb();

    final data = {
      'title': title,
      'description': desc,
      'createdAt': DateTime.now().toString()
    };
//using where to prevent sql injection
    final resultid =
        await db.update('Notes', data, where: "id = ?", whereArgs: [id]);
    return resultid;
  }

//update Note
  static Future<void> deletsNote(
    int id,
  ) async {
    final db = await initDb();

//using where to prevent sql injection
    await db.delete('Notes', where: "id = ?", whereArgs: [id]);
  }
}
