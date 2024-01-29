import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manageit_school/globalWidgets/x_margin.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/models/student.dart';
import 'package:manageit_school/providers/user_provider.dart';
import 'package:manageit_school/screens/edit_student_profile.dart';
import 'package:manageit_school/services/student_service.dart';
import 'package:manageit_school/utils/manageit_router.dart';
import 'package:provider/provider.dart';

class StudentProfileScreen extends StatefulWidget {
  static const routeName = 'StudentProfileScreen';
  const StudentProfileScreen({
    super.key,
  });

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  Student? student;
  late int studentId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    studentId = ModalRoute.of(context)!.settings.arguments as int;
    getStudent(studentId);
  }

  Future<void> getStudent(int studentId) async {
    final String? userToken =
        Provider.of<UserProvider>(context, listen: false).userToken;

    final result =
        await StudentService.getStudentDetailsById(studentId, userToken!);
    if (result != null) {
      setState(() {
        student = result;
      });
    } else {
      print('Error getting the data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUserStudent =
        Provider.of<UserProvider>(context).isUserStudent();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Student Profile'),
      ),
      body: (student == null)
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.black,
                                backgroundImage: (student!.studentPhoto != null)
                                    ? MemoryImage(
                                        base64Decode(student!.studentPhoto!),
                                      )
                                    : null,
                                child: (student!.studentPhoto == null)
                                    ? Text(
                                        student!.firstName[0],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 24),
                                      )
                                    : null,
                              ),
                            ),
                            const XMargin(width: 15),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${student!.firstName} ${student!.lastName}',
                                    softWrap: true,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Roll No: ${student!.rollNumber}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (!isUserStudent)
                          IconButton(
                            onPressed: () {
                              ManageItRouter.push(
                                      EditStudentProfileScreen.routeName,
                                      arguments: student)
                                  .then((_) {
                                getStudent(studentId);
                              });
//                             Navigator.of(context).pushNamed(
//   EditStudentProfileScreen.routeName,
//   arguments: student,
// ).then((_) {
//   getStudent(studentId);
// });
                            },
                            icon: const Icon(Icons.edit_outlined),
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        const YMargin(height: 20),
                        _buildSection(
                            'Personal Details', _getPersonalDetails()),
                        const YMargin(height: 20),
                        _buildSection(
                            'Academic Details', _getAcademicDetails()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSection(String title, List<List<Detail>> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(thickness: 1, height: 20),
        ...details.map((detailList) => DetailRow(details: detailList)),
      ],
    );
  }

  List<List<Detail>> _getPersonalDetails() {
    return [
      [
        Detail('Gender', student!.gender ?? 'NA'),
        Detail(
            'Date of Birth',
            (student!.dateOfBirth != null)
                ? DateFormat('MM/dd/yyyy')
                    .format(DateTime.parse(student!.dateOfBirth!))
                : 'NA'),
      ],
      [Detail('Mobile Number', student!.phoneNumber ?? 'NA')],
      [Detail('E-mail', student!.email ?? 'NA')],
      [
        Detail("Father's Name", student!.fatherName ?? 'NA'),
        Detail("Mother's Name", student!.motherName ?? 'NA'),
      ],
      [
        Detail("Parent's Mobile", student!.phoneNumber ?? 'NA'),
        Detail('Blood Group', student!.bloodGroup ?? 'NA'),
      ],
    ];
  }

  List<List<Detail>> _getAcademicDetails() {
    return [
      [
        Detail('Admission Date', student!.admissionDate ?? 'NA'),
        Detail('Registration Number', student!.regNumber ?? 'NA'),
      ],
      [
        Detail('Class', student!.schoolClass.className),
        Detail('Total Attendance', student!.studentAttendences ?? 'NA'),
      ],
    ];
  }
}

class DetailRow extends StatelessWidget {
  final List<Detail> details;
  const DetailRow({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: details.map((detail) => detail.build()).toList(),
    );
  }
}

class Detail {
  final String name;
  final String value;

  Detail(this.name, this.value);

  Widget build() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            softWrap: true,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          const YMargin(),
        ],
      ),
    );
  }
}
