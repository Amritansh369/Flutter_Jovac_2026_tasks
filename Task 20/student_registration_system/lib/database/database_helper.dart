import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/student_model.dart';

/// Singleton wrapper around the `students` SQLite database.
class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'student_registration.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            studentName TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            email TEXT NOT NULL,
            mobile TEXT NOT NULL,
            department TEXT NOT NULL,
            semester TEXT NOT NULL,
            cgpa REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertStudent(Student student) async {
    final db = await database;
    return db.insert('students', student.toMap());
  }

  Future<List<Student>> getAllStudents() async {
    final db = await database;
    final maps = await db.query('students', orderBy: 'id DESC');
    return maps.map((m) => Student.fromMap(m)).toList();
  }

  Future<List<Student>> searchStudents(String query) async {
    final db = await database;
    final maps = await db.query(
      'students',
      where: 'studentName LIKE ? OR rollNumber LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'id DESC',
    );
    return maps.map((m) => Student.fromMap(m)).toList();
  }

  Future<int> updateStudent(Student student) async {
    final db = await database;
    return db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> getStudentCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM students');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
