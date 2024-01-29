import 'package:manageit_school/providers/user_provider.dart';
import 'package:manageit_school/screens/add_student.dart';
import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/models/student.dart';
import 'package:manageit_school/services/student_service.dart';
import 'package:manageit_school/widgets/ind_student_box.dart';
import 'package:provider/provider.dart';

class ShowClassStudentsScreen extends StatefulWidget {
  static const routeName = 'ShowClassStudentScreen';
  // final String classname;
  // final int classId;

  const ShowClassStudentsScreen({
    super.key,
    // required this.classId,
    // required this.classname,
  });

  @override
  State<ShowClassStudentsScreen> createState() =>
      _ShowClassStudentsScreenState();
}

class _ShowClassStudentsScreenState extends State<ShowClassStudentsScreen> {
  List<Student>? students;
  late Future<List<Student>?> studentsFuture;
  late String classname;
  late int classId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    classname = args['classname'] as String;
    classId = args['classId'] as int;
    studentsFuture = fetchClassStudents();
  }

  Future<List<Student>?> fetchClassStudents() async {
    final String? userToken =
        Provider.of<UserProvider>(context, listen: false).userToken;

    final List<Student>? classStudents =
        await StudentService.getStudentsByClass(classId, userToken!);

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
        title: Text(classname),
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
