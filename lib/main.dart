import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_info/pages/add_student_page.dart';
import 'package:student_info/pages/all_students_page.dart';
import 'package:student_info/pages/home_page.dart';

import 'controllers/student_contollers.dart';

void main() {
  Get.put(StudentController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Info App',
      home: const HomePage(),
      getPages: [
        GetPage(
          name: '/addStudent',
          page: () => AddStudentPage(),
        ),
        GetPage(
          name: '/allStudents',
          page: () => AllStudentsPage(),
        ),
      ],
    );
  }
}

