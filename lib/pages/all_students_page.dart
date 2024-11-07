import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:student_info/pages/update_student_page.dart';

import '../controllers/student_contollers.dart';

class AllStudentsPage extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  AllStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    studentController.fetchStudents();

    return Scaffold(
      appBar: AppBar(title: const Text('All Students')),
      body: Obx(() => ListView.builder(
            itemCount: studentController.students.length,
            itemBuilder: (context, index) {
              final student = studentController.students[index];
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.teal[500],
                  border: const Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(student.name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle:
                      Text('Id: ${student.studentId}\nPhone: ${student.phone}\nEmail: ${student.email}\nLocation: ${student.location}',
                          style: const TextStyle(color: Colors.white)),
                  onLongPress: (){
                    Get.to(() => UpdateStudentPage( student: student));
                  },
                  onTap: (){
                    Fluttertoast.showToast(msg: "Long press to edit");
                  },
                  leading: const Icon(Icons.person,size: 35,color: Colors.white70,),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 30,),
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
                ),
              );
            },
          )),
    );
  }
}
