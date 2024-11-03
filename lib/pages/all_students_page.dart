import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/student_contollers.dart';

class AllStudentsPage extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    studentController.fetchStudents();

    return Scaffold(
      appBar: AppBar(title: Text('All Students')),
      body: Obx(() => ListView.builder(
            itemCount: studentController.students.length,
            itemBuilder: (context, index) {
              final student = studentController.students[index];
              return ListTile(
                title: Text('${student.name} (${student.studentId})'),
                subtitle:
                    Text('Phone: ${student.phone}\nEmail: ${student.email}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    headerAnimationLoop: false,
                    animType: AnimType.bottomSlide,
                    title: 'Delete',
                    desc: 'Want to delete Student ?',
                    buttonsTextStyle: const TextStyle(color: Colors.white),
                    showCloseIcon: true,
                    btnCancelOnPress: () {},
                    btnOkText: 'YES',
                    btnCancelText: 'NO',
                    btnOkOnPress: () async {
                      bool confirmDelete =
                          await studentController.deleteStudent(
                              student.id!); // Assuming confirmDelete dialog

                      if (confirmDelete) {
                        Get.snackbar("Success", "Student deleted",
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        Get.snackbar("Error", "Failed to delete student",
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                  ).show(),
                ),
              );
            },
          )),
    );
  }
}
