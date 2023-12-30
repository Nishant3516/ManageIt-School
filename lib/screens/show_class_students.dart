import 'package:flutter/material.dart';
import 'package:manageit_school/models/student.dart';
import 'package:manageit_school/services/student_service.dart';

class ShowClassStudentsScreen extends StatefulWidget {
  final int classId;

  const ShowClassStudentsScreen({super.key, required this.classId});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Students'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (students != null)
              Expanded(
                child: ListView.builder(
                  itemCount: students!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${students![index].firstName} ${students![index].lastName ?? "NA"}',
                      ),
                      subtitle: Text(
                        students![index].dateOfBirth ?? 'Date of Birth: NA',
                      ),
                      // Add more details as needed
                    );
                  },
                ),
              ),
            if (students == null)
              const Text('No students found for this class.'),
          ],
        ),
      ),
    );
  }
}
