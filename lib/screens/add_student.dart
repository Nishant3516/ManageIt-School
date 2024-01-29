import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manageit_school/controllers/controllers.dart';
import 'package:manageit_school/globalWidgets/global_widgets.dart';
import 'package:manageit_school/models/models.dart';
import 'package:manageit_school/services/services.dart';
import 'package:manageit_school/utils/manageit_router.dart';

class AddStudentScreen extends StatefulWidget {
  static const routeName = 'AddStudentScreen';
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  List<Class> _classes = [];
  Class? _selectedClass;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final _addStudentFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchClasses();
  }

  void fetchClasses() async {
    final AuthController authController = AuthController();
    final String? userToken = await authController.getToken();

    if (userToken != null) {
      final result = await ApiService.fetchClasses(userToken);

      setState(() {
        _classes = result;

        if (_classes.isNotEmpty) {
          // Check if there are route arguments
          final Class? argumentClass =
              ModalRoute.of(context)!.settings.arguments as Class?;

          // If there are arguments, find the index of the argument class
          if (argumentClass != null) {
            final int index =
                _classes.indexWhere((c) => c.id == argumentClass.id);

            // If the class is found, set _selectedClass to it
            if (index != -1) {
              _selectedClass = _classes[index];
            } else {
              _selectedClass = _classes[0];
            }
          } else {
            _selectedClass = _classes[0];
          }
        } else {
          _selectedClass = null;
        }
      });
    } else {
      // Handle the case where the user is not logged in (userToken is null)
      // You may want to redirect the user to the login screen or take appropriate action.
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _rollNumberController.dispose();
    _phoneNumberController.dispose();
    _addressLine1Controller.dispose();
    _fatherNameController.dispose();
    _startDateController.dispose();
    _dateOfBirthController.dispose();

    super.dispose();
  }

  void _addStudent() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String rollNumber = _rollNumberController.text;
    String phoneNumber = _phoneNumberController.text;
    String addressLine1 = _addressLine1Controller.text;
    String fatherName = _fatherNameController.text;
    DateTime startDate;
    DateTime dateOfBirth;

    // Perform additional input validation as needed
    if (_addStudentFormKey.currentState!.validate()) {
      try {
        startDate = DateFormat('dd-MM-yyyy').parse(_startDateController.text);
        dateOfBirth =
            DateFormat('dd-MM-yyyy').parse(_dateOfBirthController.text);
      } catch (e) {
        print("Error parsing start date: $e");
        return;
      }

      Student newStudent = Student(
        firstName: firstName,
        lastName: lastName,
        rollNumber: rollNumber,
        phoneNumber: phoneNumber,
        addressLine1: addressLine1,
        fatherName: fatherName,
        startDate: DateFormat('yyyy-MM-dd').format(startDate).toString(),
        schoolClass: _selectedClass!,
        dateOfBirth: '${dateOfBirth.toIso8601String().split('.')[0]}Z',
      );

      try {
        // Obtain user token
        final AuthController authController = AuthController();
        final String? userToken = await authController.getToken();

        if (userToken != null) {
          // Attempt to add the student with the user token
          final bool result =
              await StudentService().addStudent(userToken, newStudent);
          // Optionally, show a success message to the user
          if (result == true) {
            print("Student added successfully");
          } else {
            print("Error adding student");
          }

          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Student added successfully.'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      ManageItRouter.pop(true);
                      ManageItRouter.pop(true);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Handle the case where user token is null (user not logged in)
          print("User not logged in");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unable to add user')),
          );
        }
      } catch (e) {
        print("An error occurred while adding the student: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to add user')),
        );
      }
    } else {
      print("All fields are required");
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a date';
    }
    return null;
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
          child: Form(
            key: _addStudentFormKey,
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
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _rollNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Roll Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter roll number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressLine1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Address Line 1',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address line 1';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    // Add additional phone number validation if needed
                    return null;
                  },
                ),
                const YMargin(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _startDateController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: const InputDecoration(
                          labelText: 'Start Date',
                        ),
                        validator: _validateDate,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateOfBirthController,
                        readOnly: true,
                        onTap: () => _selectDateOfBirth(context),
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                        ),
                        validator: _validateDate,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDateOfBirth(context),
                    ),
                  ],
                ),
                const YMargin(height: 16),
                ElevatedButton(
                  onPressed: _addStudent,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _startDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateOfBirthController.text =
            DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }
}
