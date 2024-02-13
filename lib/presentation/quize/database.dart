import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/quize.dart'; // For encoding and decoding JSON

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    try {
      if (_database != null) return _database!;
      _database = await _initDB('assets/quizzes.db');
      return _database!;
    } catch (e) {
      print('Error initializing database: $e');
      throw e;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<List<Map<String, dynamic>>> fetchAllQuizzes() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> quizzes = await db.query('quizzes');
    return quizzes;
  }

  Future<void> deleteAllQuizzes() async {
    final db = await instance.database;
    await db.delete('quizzes'); // This deletes all rows in the quizzes table
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    // Creating a table for quizzes
    await db.execute('''
CREATE TABLE quizzes (
  id $idType,
  title $textType,
  createdDate $textType,
  author $textType,
  questions $textType
)
''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> createQuiz(Quiz quiz) async {
    final db = await instance.database;
    final json = quiz.toJson();
    return await db.insert('quizzes', json);
  }
}
