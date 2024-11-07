import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:student_info/controllers/student_contollers.dart';
import 'package:student_info/models/student.dart';

class UpdateStudentPage extends StatefulWidget {
  const UpdateStudentPage({super.key, required this.student});

  final Student student;

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {

  final StudentController studentController = Get.find<StudentController>();

  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController locationController;

  @override

  void initState() {
    nameController = TextEditingController(text: widget.student.name);
    idController = TextEditingController(text: widget.student.studentId);
    phoneController = TextEditingController(text: widget.student.phone);
    emailController = TextEditingController(text: widget.student.email);
    locationController = TextEditingController(text: widget.student.location);
    super.initState();
  }

  @override

  void dispose() {
    nameController.dispose();
    idController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void updateStudent () async {
    Student updatedStudent = Student(
      id: widget.student.id,
      name: nameController.text,
      studentId: idController.text,
      phone: phoneController.text,
      email: emailController.text,
      location: locationController.text,
    );
    if(updatedStudent.name.isEmpty ||
        updatedStudent.studentId.isEmpty ||
        updatedStudent.phone.isEmpty ||
        updatedStudent.email.isEmpty ||
        updatedStudent.location.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
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
          snackStyle: SnackStyle.FLOATING);
      return;
    }
    if(!updatedStudent.phone.isNum) {
      Fluttertoast.showToast(
          msg: "Enter valid number",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    if(updatedStudent.phone.length != 11) {
      Fluttertoast.showToast(
          msg: "Phone number must be 11 digits",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    if(!updatedStudent.email.isEmail) {
      Fluttertoast.showToast(
          msg: "Invalid email",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    String result = await studentController.updateStudent(updatedStudent);
    if(result == "Success") {
      Get.back();
      Get.snackbar("Success", "Student updated", snackPosition: SnackPosition.BOTTOM);
    } else if(result == "Student exists") {
      Get.snackbar("Error Updating", "Student with this ID already exists",
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
      Get.snackbar("Error", "Failed to update student",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
      ),
      body: Padding(padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'Student ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            Expanded(child: Container()),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: updateStudent,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.teal),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  minimumSize: WidgetStateProperty.all(const Size(250, 50)),
                  elevation: WidgetStateProperty.all(10),
                ),
                child: const Text('Update Student', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
