import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/models/student.dart';

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
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController rollNumberController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressLine1Controller;
  late TextEditingController addressLine2Controller;
  late TextEditingController fatherNameController;
  late TextEditingController motherNameController;
  late TextEditingController emailController;
  late TextEditingController bloodGroupController;
  late TextEditingController admissionDateController;
  late TextEditingController regNumberController;
  late TextEditingController endDateController;
  File? _image;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current data
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
    bloodGroupController =
        TextEditingController(text: widget.student.bloodGroup ?? '');
    admissionDateController =
        TextEditingController(text: widget.student.admissionDate ?? '');
    regNumberController =
        TextEditingController(text: widget.student.regNumber ?? '');
    endDateController =
        TextEditingController(text: widget.student.endDate ?? '');
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
    bloodGroupController.dispose();
    admissionDateController.dispose();
    regNumberController.dispose();
    endDateController.dispose();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _showImageOptions(context);
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 50,
                        )
                      : null,
                ),
              ),
              const YMargin(),
              _buildTextField('First Name', firstNameController),
              _buildTextField('Last Name', lastNameController),
              _buildTextField('Roll Number', rollNumberController),
              _buildTextField('Phone Number', phoneNumberController),
              _buildTextField('Address Line 1', addressLine1Controller),
              _buildTextField('Address Line 2', addressLine2Controller),
              _buildTextField('Father\'s Name', fatherNameController),
              _buildTextField('Mother\'s Name', motherNameController),
              _buildTextField('Email', emailController),
              _buildTextField('Blood Group', bloodGroupController),
              _buildTextField('Admission Date', admissionDateController),
              _buildTextField('Registration Number', regNumberController),
              _buildTextField('End Date', endDateController),
              const YMargin(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
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
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _saveChanges() {
    // Implement logic to save changes to the backend
    // Update the student object with the new data
    // widget.student.firstName = firstNameController.text;
    // widget.student.lastName = lastNameController.text;
    // widget.student.rollNumber = rollNumberController.text;
    // widget.student.phoneNumber = phoneNumberController.text;
    // widget.student.addressLine1 = addressLine1Controller.text;
    // widget.student.addressLine2 = addressLine2Controller.text;
    // widget.student.fatherName = fatherNameController.text;
    // widget.student.motherName = motherNameController.text;
    // widget.student.email = emailController.text;
    // widget.student.bloodGroup = bloodGroupController.text;
    // widget.student.admissionDate = admissionDateController.text;
    // widget.student.regNumber = regNumberController.text;
    // widget.student.endDate = endDateController.text;

    // Make API call to update student information
    Navigator.pop(context); // Uncomment to navigate back after saving changes
  }
}
