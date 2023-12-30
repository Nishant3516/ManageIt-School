import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/individual_button.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/screens/password_created_success.dart';

class CreatePasswordScreen extends StatefulWidget {
  final String email;
  const CreatePasswordScreen({super.key, required this.email});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _submitPassword() {
    // Implement password submission logic
    // Check if the entered password and confirmed password match
    // If yes, make an API call to update the user's password
    // Otherwise, show an error message
    NavigatorWidget()
        .screenReplacement(context, const PasswordCreatedSuccessScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create a new password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const YMargin(height: 20),
            const Text(
              'Enter a strong password for your account',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const YMargin(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Enter Password',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 50, color: Colors.black),
                ),
              ),
            ),
            const YMargin(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 50, color: Colors.black),
                ),
              ),
            ),
            const YMargin(height: 20),
            IndividualButton(
              buttonFunction: _submitPassword,
              buttonText: 'Submit',
              backgroundColor: const Color.fromRGBO(47, 78, 255, 0.8),
            ),
          ],
        ),
      ),
    );
  }
}
