import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/individual_button.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/screens/login.dart';

class PasswordCreatedSuccessScreen extends StatelessWidget {
  const PasswordCreatedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(23, 68, 100, 1),
              Color.fromRGBO(61, 84, 213, 0.55),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/success.png',
              height: MediaQuery.sizeOf(context).height * 0.25,
            ),
            const YMargin(height: 20),
            const Text(
              'Password Created Successfully!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const YMargin(height: 20),
            const Text(
              'Your password has been successfully updated.',
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const YMargin(height: 20),
            IndividualButton(
              buttonFunction: () {
                NavigatorWidget()
                    .screenPushReplacement(context, const LoginScreen());
              },
              buttonText: 'Back to Login',
              backgroundColor: const Color.fromRGBO(23, 68, 100, 1),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
