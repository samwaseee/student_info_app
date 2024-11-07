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
    if (newStudent.name.isEmpty ||
        newStudent.studentId.isEmpty ||
        newStudent.phone.isEmpty ||
        newStudent.email.isEmpty ||
        newStudent.location.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        barBlur: 20,
        backgroundColor: Colors.red.shade900,
        backgroundGradient: LinearGradient(
            colors: [Colors.red.shade900, Colors.red.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 1.0]),
        colorText: Colors.black87,
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Icons.error,
          color: Colors.black87,
        ),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
      );
      return;
    }
    if (!newStudent.phone.isNum) {
      Fluttertoast.showToast(
          msg: "Enter valid number",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    if (newStudent.phone.length != 11) {
      Fluttertoast.showToast(
          msg: "Phone number must be 11 digits",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    if (!newStudent.email.isEmail) {
      Fluttertoast.showToast(
          msg: "Invalid email",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    String result = await studentController.addStudent(newStudent); // Check result
    if (result == "Success") {
      Get.offAll(const HomePage());
      Get.snackbar("Success", "Student Added",
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(10));
    } else if (result == "Student exists") {
      Get.snackbar("Student Exists", "Student with this ID already exists",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade900,
          barBlur: 20,
          backgroundGradient: LinearGradient(
              colors: [Colors.red.shade400, Colors.red.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0]),
          colorText: Colors.black87,
          shouldIconPulse: true,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.person,
              color: Colors.black87),
          margin: const EdgeInsets.all(10));
    }
    else {
      Get.snackbar("Error", "Failed to add student",
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID')),
            TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone')),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email')),
            TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location')),
            Expanded(child: Container()),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _saveStudent,
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.teal),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        minimumSize: WidgetStateProperty.all(const Size(250, 50)),
                        elevation: WidgetStateProperty.all(10)),
                    child: const Text('Save',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)))),
          ],
        ),
      ),
    );
  }
}
