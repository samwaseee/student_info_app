import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:student_info/services/database_helper.dart';

import '../models/student.dart';

class StudentController extends GetxController {
  final DatabaseHelper _dbHelper =
      DatabaseHelper(); //Creates an instance of DatabaseHelper to interact with the database.
  var students = <Student>[].obs; //Creates an observable list of students.

  Future<bool> addStudent(Student student) async {
    int result =
        await _dbHelper.insertStudent(student); // Insert into the database
    if (result > 0) {
      fetchStudents(); // Refresh the students list on successful insertion
      return true; // Return success
    }
    return false; // Return failure if insertion result <= 0
  }

  Future<void> fetchStudents() async {
    var fetchedStudents = await _dbHelper.getStudents();
    students.assignAll(fetchedStudents);
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
