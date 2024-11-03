import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:student_info/pages/home_page.dart';

import '../controllers/student_contollers.dart';
import '../models/student.dart';

class AddStudentPage extends StatelessWidget {
  final StudentController studentController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  AddStudentPage({super.key});

  void _saveStudent() async {
    Student newStudent = Student(
      name: nameController.text,
      studentId: idController.text,
      phone: phoneController.text,
      email: emailController.text,
      location: locationController.text,
    );
    if(newStudent.name.isEmpty || newStudent.studentId.isEmpty || newStudent.phone.isEmpty || newStudent.email.isEmpty || newStudent.location.isEmpty) {
      Get.snackbar("Error", "All fields are required", snackPosition: SnackPosition.BOTTOM, barBlur: 20 , backgroundGradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.red.shade500], begin: Alignment.topLeft, end: Alignment.bottomRight , stops: [0.0, 1.0]
      ), colorText: Colors.black87, margin: EdgeInsets.all(10),

          icon: Icon(
            Icons.error,
            color: Colors.black87,
          ),
          shouldIconPulse: true,
          isDismissible: true,
          duration: Duration(seconds: 2),
          overlayBlur: 0,
          overlayColor: Colors.transparent,
          boxShadows: [
            BoxShadow(
              color: Colors.red.shade400,
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
          snackStyle: SnackStyle.FLOATING,);
      return;
    }
    if(!newStudent.phone.isNum) {
      Fluttertoast.showToast(msg: "Enter valid number", backgroundColor: Colors.red, textColor: Colors.white);
      return;
    }
    if(newStudent.phone.length != 11) {
      Fluttertoast.showToast(msg: "Phone number must be 11 digits", backgroundColor: Colors.red, textColor: Colors.white);
      return;
    }
    if(!newStudent.email.isEmail) {
      Fluttertoast.showToast(msg: "Invalid email", backgroundColor: Colors.red, textColor: Colors.white);
      return;
    }
    bool success = await studentController.addStudent(newStudent); // Check result
    if (success) {
      Get.offAll(HomePage());
      Get.snackbar("Success", "Student Added", snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.all(10));
    } else {
      Get.snackbar("Error", "Failed to add student", snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.all(10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: idController, decoration: InputDecoration(labelText: 'ID')),
            TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: locationController, decoration: InputDecoration(labelText: 'Location')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveStudent, child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
