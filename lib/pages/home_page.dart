import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_info/pages/add_student_page.dart';

import 'all_students_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text('Student Info', style: GoogleFonts.aboreto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://cdn-icons-png.flaticon.com/512/1305/1305711.png",
                width: 300,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Text('Failed to load image', style: TextStyle(color: Colors.red));
                },
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () => Get.to(() => AddStudentPage()),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.teal),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  minimumSize: WidgetStateProperty.all(Size(250, 50)),
                  elevation: WidgetStateProperty.all(10),
                ),
                child: Text('Add Student', style: GoogleFonts.aboreto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()=> Get.to(() => AllStudentsPage()),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.teal),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  minimumSize: WidgetStateProperty.all(Size(250, 50)),
                  elevation: WidgetStateProperty.all(10),
                ),
                child: Text('View Students', style: GoogleFonts.aboreto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
            ],
          )
        ));
  }
}
