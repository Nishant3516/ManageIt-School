import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:manageit_school/constants/constants.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/models/student.dart';
import 'package:manageit_school/providers/user_provider.dart';
import 'package:manageit_school/services/student_service.dart';
import 'package:provider/provider.dart';

class EditStudentProfileScreen extends StatefulWidget {
  final Student student;
  const EditStudentProfileScreen({
    super.key,
    required this.student,
  });

  @override
  State<EditStudentProfileScreen> createState() =>
      _EditStudentProfileScreenState();
}

class _EditStudentProfileScreenState extends State<EditStudentProfileScreen> {
  final List<String> genderOptions = Constants().genderOptions;
  final List<String> bloodGroups = Constants().bloodGroups;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController rollNumberController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressLine1Controller;
  late TextEditingController addressLine2Controller;
  late TextEditingController fatherNameController;
  late TextEditingController motherNameController;
  late TextEditingController emailController;
  late TextEditingController admissionDateController;
  late TextEditingController regNumberController;
  File? _image;
  late String? _selectedGender;
  late String? _selectedBloodGroup;
  final _editStudentProfileFormKey = GlobalKey<FormState>();
  late String? studentImage;

  @override
  void initState() {
    super.initState();
    studentImage = widget.student.studentPhoto;
    _selectedGender =
        (widget.student.gender != null) ? widget.student.gender : null;
    _selectedBloodGroup =
        (widget.student.bloodGroup != null) ? widget.student.bloodGroup : null;
    firstNameController = TextEditingController(text: widget.student.firstName);
    lastNameController = TextEditingController(text: widget.student.lastName);
    rollNumberController =
        TextEditingController(text: widget.student.rollNumber);
    phoneNumberController =
        TextEditingController(text: widget.student.phoneNumber);
    addressLine1Controller =
        TextEditingController(text: widget.student.addressLine1);
    addressLine2Controller =
        TextEditingController(text: widget.student.addressLine2 ?? '');
    fatherNameController =
        TextEditingController(text: widget.student.fatherName);
    motherNameController =
        TextEditingController(text: widget.student.motherName ?? '');
    emailController = TextEditingController(text: widget.student.email ?? '');
    admissionDateController =
        TextEditingController(text: widget.student.admissionDate ?? '');
    regNumberController =
        TextEditingController(text: widget.student.regNumber ?? '');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    rollNumberController.dispose();
    phoneNumberController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    emailController.dispose();
    admissionDateController.dispose();
    regNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Form(
            key: _editStudentProfileFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showImageOptions(context);
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: (studentImage != null)
                            ? MemoryImage(
                                Uint8List.fromList(
                                  base64Decode(studentImage!),
                                ),
                              )
                            : null,
                        child: (widget.student.studentPhoto == null)
                            ? const Icon(
                                Icons.camera_alt,
                                size: 30,
                              )
                            : null,
                      ),
                    ),
                    if (_image != null) const Text("to"),
                    if (_image != null)
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            (_image != null) ? FileImage(_image!) : null,
                        child: (_image == null &&
                                widget.student.studentPhoto == null)
                            ? const Icon(
                                Icons.camera_alt,
                                size: 30,
                              )
                            : null,
                      ),
                  ],
                ),
                const YMargin(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: const UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: rollNumberController,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Roll Number',
                    border: const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your roll number';
                    }

                    // Check if the entered value is a valid integer
                    try {
                      int.parse(value);
                    } catch (e) {
                      return 'Please enter a valid integer for roll number';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    counterText: '',
                    border: const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Phone Number';
                    }

                    RegExp regex = RegExp(r'^[0-9]+$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid numeric Phone Number';
                    }

                    if (value.length != 10) {
                      return 'Phone Number must be 10 digits long';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: addressLine1Controller,
                  decoration: InputDecoration(
                    labelText: 'Address Line 1',
                    border: const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Address Line 1';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: addressLine2Controller,
                  decoration: InputDecoration(
                    labelText: 'Address Line 2',
                    border: const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Address Line 2';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: fatherNameController,
                  decoration: InputDecoration(
                    labelText: 'Father\'s Name',
                    border: const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Father\'s Name';
                    }

                    // Additional validation: Only allow alphabets and spaces
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Please enter a valid Father\'s Name';
                    }

                    return null; // Return null if all validations pass
                  },
                ),
                TextFormField(
                  controller: motherNameController,
                  decoration: InputDecoration(
                    labelText: 'Mother\'s Name',
                    border: const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Mother\'s Name';
                    }

                    // Additional validation: Only allow alphabets and spaces
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Please enter a valid Mother\'s Name';
                    }

                    return null; // Return null if all validations pass
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // You can add a more comprehensive email validation logic here
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                DropdownButtonFormField<String>(
                  value: (_selectedGender == null)
                      ? _selectedGender
                      : toTitleCase(_selectedGender!),
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
                DropdownButtonFormField<String>(
                  value: _selectedBloodGroup,
                  items: bloodGroups.map((String bloodGroup) {
                    return DropdownMenuItem<String>(
                      value: bloodGroup,
                      child: Text(bloodGroup),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _selectedBloodGroup = newValue;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Blood Group',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your blood group';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: admissionDateController,
                  decoration: InputDecoration(
                    labelText: 'Admission Date (YYYY-MM-DD)',
                    border: const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the admission date';
                    }

                    // Define the expected date format
                    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

                    // Try to parse the entered value as a date
                    try {
                      dateFormat.parseStrict(value);
                    } catch (e) {
                      return 'Please enter a valid date in the format yyyy-MM-dd';
                    }

                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: regNumberController,
                  decoration: InputDecoration(
                    labelText: 'Registration Number',
                    border: const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the registration number';
                    }

                    return null; // Return null if the input is valid
                  },
                ),
                const YMargin(height: 20),
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String toTitleCase(String text) {
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('From Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('From Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final _imagePicker = ImagePicker();
    final pickedFile = await _imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveChanges() async {
    String? studentPhoto;
    String? studentPhotoContentType;
    final String? userToken =
        Provider.of<UserProvider>(context, listen: false).userToken;

    if (_image != null) {
      // Convert image to base64
      List<int> imageBytes = await _image!.readAsBytes();
      studentPhoto = base64.encode(imageBytes);
      studentPhotoContentType = 'image/png';
    } else if (studentImage != null) {
      studentPhoto = studentImage;
    } else {
      studentPhoto = null;
    }

    // Create a map with the updated student data
    Student updatedData = Student(
      id: widget.student.id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      rollNumber: rollNumberController.text,
      phoneNumber: phoneNumberController.text,
      addressLine1: addressLine1Controller.text,
      addressLine2: addressLine2Controller.text,
      fatherName: fatherNameController.text,
      motherName: motherNameController.text,
      gender: _selectedGender!.toUpperCase(),
      email: emailController.text,
      bloodGroup: _selectedBloodGroup,
      admissionDate: admissionDateController.text,
      regNumber: regNumberController.text,
      schoolClass: widget.student.schoolClass,
      studentPhoto: studentPhoto != null ? studentPhoto : null,
      studentPhotoContentType: studentPhotoContentType,
    );

    // Invoke the method to update student details
    if (_editStudentProfileFormKey.currentState!.validate()) {
      print("Updating data...");
      try {
        final bool isDataUpdated = await StudentService().updateStudentDetails(
          updatedData,
          widget.student.id!,
          userToken!,
        );
        if (isDataUpdated) {
          print("Data successfully updated");
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
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          print('Error updating the data');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unable to update student data')),
          );
        }
      } catch (e) {
        print("Error occurred while updating the data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to update student data')),
        );
      }
    }
  }
}
