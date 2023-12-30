import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/individual_button.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/screens/login.dart';
import 'package:manageit_school/screens/otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    // _forgotPasswordFormKey.currentState?.dispose();
    super.dispose();
  }

  void _sendResetLink() async {
    NavigatorWidget()
        .screenReplacement(context, const OTPScreen(email: 'xyz@gmail.com'));
    //   if (_forgotPasswordFormKey.currentState!.validate()) {
    //     // Call your authentication service to send the reset link
    //     try {
    //       await AuthService().sendResetLink(_emailController.text);
    //       // Show a success message or navigate to a success screen
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(
    //           content: Text('Password reset link sent successfully.'),
    //         ),
    //       );
    //     } catch (e) {
    //       // Handle the error, possibly show an error message to the user
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(
    //           content: Text('Failed to send password reset link.'),
    //         ),
    //       );
    //     }
    //   }
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
              'Forgot Password?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const YMargin(height: 20),
            const Text(
              'Enter your email address below to receive a password reset link.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const YMargin(height: 20),
            Form(
              key: _forgotPasswordFormKey,
              child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  // Implement email validation logic
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'example@example.com',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 50, color: Colors.black),
                  ),
                ),
              ),
            ),
            const YMargin(height: 20),
            IndividualButton(
              buttonFunction: _sendResetLink,
              buttonText: 'Send Reset Link',
              backgroundColor: const Color.fromRGBO(47, 78, 255, 0.8),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                child: const Text('Back to Login'),
                onPressed: () {
                  NavigatorWidget()
                      .screenPushReplacement(context, const LoginScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
