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
  final int classId;

  const ShowClassStudentsScreen({
    super.key,
    required this.classId,
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
    fetchClassStudents();
  }

  Future<void> fetchClassStudents() async {
    final List<Student>? classStudents =
        await StudentService.getStudentsByClass(widget.classId);

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
    final bool isUserStudent =
        Provider.of<UserProvider>(context).isUserStudent();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Students'),
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
                              indStudent: students![index],
                              isUserStudent: isUserStudent);
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
  final bool isUserStudent;
  final Student indStudent;

  const IndStudentBox({
    super.key,
    required this.indStudent,
    required this.isUserStudent,
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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: boxColor,
      ),
      child: ListTile(
        onTap: () {
          NavigatorWidget().screenReplacement(
              context, StudentProfileScreen(student: widget.indStudent));
        },
        contentPadding: const EdgeInsets.all(10),
        style: ListTileStyle.list,
        leading: const CircleAvatar(
          child: CircleAvatar(
            radius: 30,
          ),
        ),
        subtitle: Text(widget.indStudent.id!.toString()),
        title: Text(
          '${toTitleCase(widget.indStudent.firstName)} ${(widget.indStudent.lastName != null) ? toTitleCase(widget.indStudent.lastName!) : ' '}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: (widget.isUserStudent)
            ? PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'edit') {
                    NavigatorWidget().screenReplacement(context,
                        EditStudentProfileScreen(student: widget.indStudent));
                  } else if (value == 'delete') {}
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

  void deleteSTudent(int studentIdToDelete, String authToken) async {
    // Call the deleteStudentById function
    await StudentService().deleteStudentById(studentIdToDelete, authToken);

    // Show a dialog box on successful deletion
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Student deleted successfully.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Close the dialog box
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
