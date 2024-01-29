import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:manageit_school/models/models.dart';
import 'package:manageit_school/providers/user_provider.dart';
import 'package:manageit_school/screens/screens.dart';
import 'package:manageit_school/services/services.dart';
import 'package:manageit_school/utils/manageit_router.dart';
import 'package:provider/provider.dart';

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
          // NavigatorWidget().screenReplacement(
          //     context, StudentProfileScreen(studentId: widget.indStudent.id!));
          ManageItRouter.push(StudentProfileScreen.routeName,
              arguments: widget.indStudent.id!);
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
                    ManageItRouter.push(EditStudentProfileScreen.routeName,
                        arguments: widget.indStudent);
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
      const SnackBar(
        content: Text('Student deleted'),
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
