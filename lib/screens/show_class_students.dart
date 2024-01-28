import 'dart:math';
import 'package:manageit_school/providers/user_provider.dart';
import 'package:manageit_school/screens/add_student.dart';
import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/models/student.dart';
import 'package:manageit_school/screens/edit_student_profile.dart';
import 'package:manageit_school/screens/student_profile.dart';
import 'package:manageit_school/services/student_service.dart';
import 'package:provider/provider.dart';

class ShowClassStudentsScreen extends StatefulWidget {
  final String classname;
  final int classId;

  const ShowClassStudentsScreen({
    super.key,
    required this.classId,
    required this.classname,
  });

  @override
  State<ShowClassStudentsScreen> createState() =>
      _ShowClassStudentsScreenState();
}

class _ShowClassStudentsScreenState extends State<ShowClassStudentsScreen> {
  List<Student>? students;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchClassStudents();
  }

  Future<void> fetchClassStudents() async {
    final String? userToken = Provider.of<UserProvider>(context).userToken;

    final List<Student>? classStudents =
        await StudentService.getStudentsByClass(widget.classId, userToken!);

    if (classStudents != null) {
      setState(() {
        students = classStudents;
      });
    } else {
      setState(() {
        students = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classname),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  NavigatorWidget()
                      .screenReplacement(context, const AddStudentScreen());
                },
                icon: const Icon(Icons.add_outlined),
                label: const Text('Add Student')),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              (students == null)
                  ? const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          YMargin(),
                          Text('Loading students for this class.'),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: students!.length,
                        itemBuilder: (context, index) {
                          return IndStudentBox(
                            students: students,
                            indStudent: students![index],
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndStudentBox extends StatefulWidget {
  final Student indStudent;
  final List<Student>? students;

  const IndStudentBox({
    super.key,
    required this.indStudent,
    required this.students,
  });

  @override
  State<IndStudentBox> createState() => _IndStudentBoxState();
}

class _IndStudentBoxState extends State<IndStudentBox> {
  Color _getRandomPastelColor() {
    final List<Color> pastelColors = [
      const Color(0xFFB2CCFF),
      const Color(0xFFD1A7FF),
      const Color(0xFFFFC3A0),
      const Color(0xFFFFCB80),
      const Color(0xFFB2F7EF),
    ];
    return pastelColors[Random().nextInt(pastelColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    Color boxColor = _getRandomPastelColor();
    final bool isUserStudent =
        Provider.of<UserProvider>(context).isUserStudent();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: boxColor,
      ),
      child: ListTile(
        onTap: () {
          NavigatorWidget().screenReplacement(
              context, StudentProfileScreen(studentId: widget.indStudent.id!));
        },
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(
          child: CircleAvatar(
            radius: 30,
            child: Text(widget.indStudent.firstName[0]),
          ),
        ),
        subtitle: Text(widget.indStudent.id!.toString()),
        title: Text(
          '${toTitleCase(widget.indStudent.firstName)} ${(widget.indStudent.lastName != null) ? toTitleCase(widget.indStudent.lastName!) : ' '}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: (!isUserStudent)
            ? PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'edit') {
                    NavigatorWidget().screenReplacement(context,
                        EditStudentProfileScreen(student: widget.indStudent));
                  } else if (value == 'delete') {
                    // deleteStudent(widget.indStudent.id!);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                    ),
                  ),
                ],
                child: const Icon(Icons.more_vert_outlined),
              )
            : null,
      ),
    );
  }

  String toTitleCase(String name) {
    if (name.isEmpty) {
      return name;
    }
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  // void deleteStudent(int studentIdToDelete) async {
  //   final String? userToken = Provider.of<UserProvider>(context).userToken;

  //   // Save a copy of the student being deleted for Undo
  //   Student deletedStudent = widget.indStudent;

  //   // Call the deleteStudentById function
  //   await StudentService().deleteStudentById(studentIdToDelete, userToken!);

  //   // Remove the student from the list immediately
  //   try {
  //     setState(() {
  //       widget.students?.remove(widget.indStudent);
  //     });
  //   } catch (e) {
  //     print("Error removing student: $e");
  //   }

  //   // Show a Snackbar with an Undo button
  //   final ScaffoldMessengerState scaffoldMessenger =
  //       ScaffoldMessenger.of(context);

  //   // Show the Snackbar with an Undo button
  //   scaffoldMessenger.showSnackBar(
  //     SnackBar(
  //       content: const Text('Student deleted'),
  //       action: SnackBarAction(
  //         label: 'Undo',
  //         onPressed: () {
  //           // If Undo is pressed, add the student back to the list
  //           setState(() {
  //             widget.students?.insert(0, deletedStudent);
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }
}
