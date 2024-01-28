import 'package:flutter/material.dart';
import 'package:manageit_school/controllers/auth_controller.dart';
import 'package:manageit_school/globalWidgets/divider_with_text.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/models/class.dart';
import 'package:manageit_school/models/student.dart';
import 'package:manageit_school/providers/user_provider.dart';
import 'package:manageit_school/screens/student_profile.dart';
import 'package:manageit_school/services/api_service.dart';
import 'package:manageit_school/services/student_service.dart';
import 'package:provider/provider.dart';

class SearchStudentScreen extends StatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  State<SearchStudentScreen> createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  int? enteredId;
  List<Student>? students = [];
  List<Class> classesList = [];
  Class? selectedClass;
  Student? selectedStudent;
  bool searchError = false;

  @override
  void initState() {
    super.initState();
    fetchClasses();
  }

  Future<void> fetchClasses() async {
    final AuthController authController = AuthController();
    final String? userToken = await authController.getToken();

    if (userToken != null) {
      final result = await ApiService.fetchClasses(userToken);

      setState(() {
        classesList = result;
        if (classesList.isNotEmpty) {
          selectedClass = classesList[0];
          fetchStudentsFromClass(selectedClass!.id);
        } else {
          selectedClass = null;
        }
      });
    }
  }

  Future<void> fetchStudentsFromClass(int classId) async {
    final String? userToken = Provider.of<UserProvider>(context).userToken;

    setState(() {
      selectedStudent = null;
    });
    final List<Student>? classStudents =
        await StudentService.getStudentsByClass(classId, userToken!);
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

  void showErrorMessage() {
    setState(() {
      searchError = true;
    });

    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          searchError = false;
        });
      },
    );
  }

  Future<void> fetchStudentFromID(int? id) async {
    final String? userToken = Provider.of<UserProvider>(context).userToken;

    setState(() {
      selectedStudent = null;
    });
    // Check if the entered ID is valid
    if (id != null && id > 0) {
      final Student? result =
          await StudentService.getStudentDetailsById(id, userToken!);
      if (result != null) {
        print(result);
        setState(() {
          selectedStudent = result;
          searchError = false;
        });
      } else {
        setState(() {
          selectedStudent = null;
          showErrorMessage();
        });
      }
    } else {
      print('Invalid ID');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  enteredId = int.tryParse(value);
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter Student ID',
                border: OutlineInputBorder(),
              ),
            ),
            const YMargin(height: 20),
            ElevatedButton(
              onPressed: () {
                if (enteredId != null) {
                  fetchStudentFromID(enteredId);
                  setState(() {
                    selectedStudent = null;
                  });
                } else if (selectedClass != null) {
                } else {
                  print('Invalid input');
                }
              },
              child: const Text('Search'),
            ),
            if (searchError)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'No student found with the entered ID.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const YMargin(height: 20),
            const DividerWithText(text: 'OR'),
            DropdownButtonFormField<Class>(
              value: selectedClass,
              items: classesList.map((Class schoolClass) {
                return DropdownMenuItem<Class>(
                  value: schoolClass,
                  child: Text(schoolClass.className),
                );
              }).toList(),
              onChanged: (Class? newValue) {
                setState(() {
                  selectedClass = newValue!;
                  fetchStudentsFromClass(newValue.id);
                  setState(() {
                    selectedStudent = null;
                  });
                });
              },
              decoration: const InputDecoration(
                labelText: 'Class',
              ),
            ),
            const YMargin(height: 20),
            if (students?.isNotEmpty == true)
              Column(
                children: [
                  if (students!.length > 1)
                    Column(
                      children: [
                        DropdownButtonFormField<Student>(
                          value: selectedStudent,
                          decoration: const InputDecoration(
                            labelText: 'Select Student',
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedStudent = value!;
                            });
                          },
                          items: students!
                              .map<DropdownMenuItem<Student>>(
                                (student) => DropdownMenuItem<Student>(
                                  value: student, // Use student ID as the value
                                  child: Text(
                                    '${student.firstName} ${student.lastName ?? ''}',
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const YMargin(height: 20),
                      ],
                    ),
                ],
              ),
            if (selectedStudent != null)
              ListTile(
                onTap: () {
                  NavigatorWidget().screenReplacement(context,
                      StudentProfileScreen(studentId: selectedStudent!.id!));
                },
                leading: const CircleAvatar(
                  radius: 20,
                ),
                title: Text(
                    '${selectedStudent!.firstName} ${(selectedStudent!.lastName ?? "NA")}'),
                subtitle: Text(selectedStudent!.schoolClass.classLongName),
              ),
          ],
        ),
      ),
    );
  }
}
