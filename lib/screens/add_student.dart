import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/models/class.dart';
import 'package:manageit_school/models/student.dart';
import 'package:manageit_school/services/api_service.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  List<Class> _classes = [];
  Class? _selectedClass;
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    fetchClasses();
  }

  void fetchClasses() async {
    final result = await ApiService.fetchClasses();

    setState(() {
      _classes = result;
      if (_classes.isNotEmpty) {
        _selectedClass = _classes[0];
      } else {
        _selectedClass = null;
      }
    });
  }

  @override
  void dispose() {
    _studentIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _rollNumberController.dispose();
    _phoneNumberController.dispose();
    _addressLine1Controller.dispose();
    _fatherNameController.dispose();
    _startDateController.dispose();

    super.dispose();
  }

  void _addStudent() async {
    // Get input values
    String studentId = _studentIdController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String rollNumber = _rollNumberController.text;
    String phoneNumber = _phoneNumberController.text;
    String addressLine1 = _addressLine1Controller.text;
    String fatherName = _fatherNameController.text;
    DateTime startDate;

    try {
      startDate = DateFormat('dd-MM-yyyy').parse(_startDateController.text);
    } catch (e) {
      print("Error parsing start date: $e");
      // Handle the error, possibly show a message to the user
      return;
    }

    // Perform additional input validation as needed
    if (studentId.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        rollNumber.isEmpty ||
        phoneNumber.isEmpty ||
        addressLine1.isEmpty ||
        fatherName.isEmpty ||
        _selectedGender == null ||
        _selectedClass == null) {
      // Show a message to the user indicating that all fields are required
      print("All fields are required");
      return;
    }

    // Create student object
    Student newStudent = Student(
      firstName: firstName,
      lastName: lastName,
      rollNumber: rollNumber,
      phoneNumber: phoneNumber,
      addressLine1: addressLine1,
      fatherName: fatherName,
      // gender: _selectedGender!,
      startDate: startDate.toString(),
      schoolClass: _selectedClass!,
    );

    try {
      // Attempt to add the student
      await ApiService.addStudent(newStudent);
      // Optionally, show a success message to the user
      print("Student added successfully");
    } catch (e) {
      // Handle the error, possibly show a message to the user
      print("An error occurred while adding the student: $e");
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Student added successfully.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Navigator.of(context).pop();
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _selectedClass == null
                  ? const CircularProgressIndicator()
                  : DropdownButtonFormField<Class>(
                      value: _selectedClass,
                      items: _classes.map((Class schoolClass) {
                        return DropdownMenuItem<Class>(
                          value: schoolClass,
                          child: Text(schoolClass.className),
                        );
                      }).toList(),
                      onChanged: (Class? newValue) {
                        setState(() {
                          _selectedClass = newValue!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Class',
                      ),
                    ),
              const YMargin(height: 16),
              TextField(
                controller: _studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                ),
              ),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              TextField(
                controller: _rollNumberController,
                decoration: const InputDecoration(
                  labelText: 'Roll Number',
                ),
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              TextField(
                controller: _addressLine1Controller,
                decoration: const InputDecoration(
                  labelText: 'Address Line 1',
                ),
              ),
              TextField(
                controller: _fatherNameController,
                decoration: const InputDecoration(
                  labelText: 'Father Name',
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: genderOptions.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Gender',
                ),
              ),
              const YMargin(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _startDateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: const InputDecoration(
                        labelText: 'Start Date',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const YMargin(height: 16),
              ElevatedButton(
                onPressed: _addStudent,
                child: const Text('Add Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _startDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }
}
