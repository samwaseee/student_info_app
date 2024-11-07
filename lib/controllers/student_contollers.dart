import 'package:get/get.dart';
import 'package:student_info/services/database_helper.dart';

import '../models/student.dart';

class StudentController extends GetxController {
  final DatabaseHelper _dbHelper =
      DatabaseHelper(); //Creates an instance of DatabaseHelper to interact with the database.
  var students = <Student>[].obs; //Creates an observable list of students.

  Future<String> addStudent(Student student) async {
    Student? existingStudent = await _dbHelper.getStudentById(student.studentId);
    if (existingStudent != null) {
      return "Student exists";
    }

    int result = await _dbHelper.insertStudent(student); // Insert into the database
    if (result > 0) {
      fetchStudents(); // Refresh the students list on successful insertion
      return "Success"; // Return success
    }
    return "Error"; // Return failure if insertion result <= 0
  }

  Future<void> fetchStudents() async {
    var fetchedStudents = await _dbHelper.getStudents();
    students.assignAll(fetchedStudents);
  }

  Future<String> updateStudent(Student student) async {
    Student? existingStudent = await _dbHelper.getStudentById(student.studentId);
    if (existingStudent != null && existingStudent.id != student.id) {
      return "Student exists";
    }
    int result = await _dbHelper.updateStudent(student);
    if (result > 0) {
      fetchStudents();
      return "Success";
    }
    return "Error";
  }

  Future<bool> deleteStudent(int id) async {
    int result = await _dbHelper.deleteStudent(id);
    if (result > 0) {
      fetchStudents();
      return true;
    }
    return false;
  }
}
