import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:student_info/models/student.dart';

class DatabaseHelper {
  // Database name
  static const _databaseName = "students.db";

  // Database version
  static const _databaseVersion = 1;

  // Table name
  static const tableStudents = 'students';

  // Column names
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnStudentId = 'studentId';
  static const columnPhone = 'phone';
  static const columnEmail = 'email';
  static const columnLocation = 'location';

  // Singleton pattern for DatabaseHelper
  static final DatabaseHelper _instance = DatabaseHelper
      ._internal(); //A static and final instance of the DatabaseHelper class, ensuring only one instance exists throughout the app. This is part of the singleton pattern.
  Database? _database; //A private variable to store the database instance.

  factory DatabaseHelper() =>
      _instance; // A factory constructor that returns the single instance of DatabaseHelper.

  DatabaseHelper._internal(); //A private constructor to prevent external instantiation.

  //database getter: Asynchronously gets the database instance. If it's not initialized, it calls _initDb to create it.
  // _initDb method:
  // Gets the database path using getDatabasesPath and join.
  // Opens the database using openDatabase.
  // If the database doesn't exist, it creates the students table with the specified columns using onCreate.

  Future<Database> get database async {
    //Defines a getter named database that returns a Future<Database>. This getter is responsible for providing access to the database instance.
    if (_database != null) {
      return _database!; //If the _database variable is not null (meaning the database is already initialized), it returns the existing instance. The ! is used to assert that _database is not null.
    }
    _database =
        await _initDb(); //If the _database variable is null, it calls the _initDb method to initialize the database.
    return _database!;
  }

  Future<Database> _initDb() async {
    //Defines a private asynchronous method named _initDb that returns a Future<Database>. This method is responsible for initializing the database.
    final path = join(await getDatabasesPath(),
        'students.db'); //Gets the path to the database file using getDatabasesPath (which provides the default directory for storing databases) and join (which combines path segments). The database file will be named students.db.
    return await openDatabase(
      path,
      //Calls the openDatabase function to open or create the database at the specified path.
      version: _databaseVersion,
      onCreate: (db, version) async {
        //If the database doesn't exist, it creates the students table with the specified columns using the onCreate callback.
        await db.execute('''
          CREATE TABLE $tableStudents (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnStudentId TEXT NOT NULL UNIQUE,
            $columnPhone TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnLocation TEXT NOT NULL
          )
          ''');
      },
    );
  }

  //insertStudent: Inserts a Student object into the students table.
  // getStudents: Retrieves all students from the students table and maps them to Student objects.
  // deleteStudent: Deletes a student from the students table based on their ID.

  Future<int> insertStudent(Student student) async {
    //Defines an asynchronous method named insertStudent that takes a Student object as an argument and returns void. This method inserts the student object into the students table.
    final db = await database;
    return await db.insert(
        tableStudents,
        student
            .toMap()); //Inserts the student data into the students table. student.toMap() is likely a method in the Student class that converts the object into a map suitable for insertion into the database.
  }

  Future<List<Student>> getStudents() async {
    //Defines an asynchronous method named getStudents that returns a List<Student>. This method retrieves all students from the students table and maps them to Student objects.
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
        tableStudents); //Queries the students table and retrieves all rows as a list of maps. Each map represents a student record.
    return maps
        .map((e) => Student.fromMap(e))
        .toList(); //Maps each map to a Student object using the Student.fromMap method and returns the list of Student objects.
  }

  Future<Student?> getStudentById (String studentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
        tableStudents,
        where: '$columnStudentId = ?',
        whereArgs: [studentId]
    );
    if (maps.isNotEmpty) {
      return Student.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateStudent(Student student) async {
    final db = await database;
    return await db.update(tableStudents, student.toMap(),
        where: '$columnId = ?',
        whereArgs: [student.id]
    ); //Updates a student in the students table based on their ID.
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete(tableStudents, where: '$columnId = ?', whereArgs: [
      id
    ]); //Deletes a student from the students table based on their ID.
  }
}
