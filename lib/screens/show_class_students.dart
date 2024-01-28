import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
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
  late Future<List<Student>?> studentsFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    studentsFuture = fetchClassStudents();
  }

  Future<List<Student>?> fetchClassStudents() async {
    final String? userToken =
        Provider.of<UserProvider>(context, listen: false).userToken;

    final List<Student>? classStudents =
        await StudentService.getStudentsByClass(widget.classId, userToken!);

    return classStudents;
  }

  Future<void> _refresh() async {
    setState(() {
      studentsFuture = fetchClassStudents();
    });
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
              label: const Text('Add Student'),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Student>?>(
          future: studentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  children: [
                    YMargin(),
                    CircularProgressIndicator(),
                    Text("Loading students...")
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No students available for this class.'),
              );
            } else {
              students = snapshot.data;
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: students!.length,
                itemBuilder: (context, index) {
                  return IndStudentBox(
                    students: students,
                    indStudent: students![index],
                    onDelete: (studentId) {
                      setState(() {
                        students!
                            .removeWhere((student) => student.id == studentId);
                      });
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class IndStudentBox extends StatefulWidget {
  final Student indStudent;
  final List<Student>? students;
  final Function(int) onDelete;

  const IndStudentBox(
      {super.key,
      required this.indStudent,
      required this.students,
      required this.onDelete});

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
        Provider.of<UserProvider>(context, listen: false).isUserStudent();

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
          radius: 25,
          backgroundImage: widget.indStudent.studentPhoto != null
              ? MemoryImage(
                  Uint8List.fromList(
                    base64Decode(widget.indStudent.studentPhoto!),
                  ),
                )
              : null,
          child: widget.indStudent.studentPhoto == null
              ? Text(widget.indStudent.firstName[0])
              : null,
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
                    deleteStudent(widget.indStudent.id!);
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

  void deleteStudent(int studentIdToDelete) async {
    final String? userToken =
        Provider.of<UserProvider>(context, listen: false).userToken;

    // Save a copy of the student being deleted for Undo
    Student deletedStudent = widget.indStudent;

    // Call the deleteStudentById function
    await StudentService().deleteStudentById(studentIdToDelete, userToken!);

    // Remove the student from the list immediately
    try {
      setState(() {
        widget.onDelete(studentIdToDelete);
      });
    } catch (e) {
      print("Error removing student: $e");
    }

    // Show a Snackbar with an Undo button
    final ScaffoldMessengerState scaffoldMessenger =
        ScaffoldMessenger.of(context);

    // Show the Snackbar with an Undo button
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: const Text('Student deleted'),
        // action: SnackBarAction(
        //   label: 'Undo',
        //   onPressed: () {
        //     // If Undo is pressed, add the student back to the list
        //     setState(() {
        //       widget.students?.insert(0, deletedStudent);
        //     });
        //   },
        // ),
      ),
    );
  }
}
