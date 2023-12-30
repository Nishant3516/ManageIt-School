import 'dart:async';
import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/individual_button.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/screens/create_password.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  int _timerSeconds = 60;
  late Timer _resendTimer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the screen is first created
    _startTimer();
  }

  void _startTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          // Stop the timer when it reaches 0
          _resendTimer.cancel();
        }
      });
    });
  }

  void _verifyOTP(BuildContext context) {
    // Implement OTP verification logic
    // Compare the entered OTP with the one sent to the user's email
    // If it matches, proceed to the next screen (e.g., password reset screen)
    // Otherwise, show an error message

    // Reset the timer when OTP is verified
    _resetTimer();

    NavigatorWidget().screenReplacement(
      context,
      const CreatePasswordScreen(
        email: 'xyz',
      ),
    );
  }

  void _resetTimer() {
    setState(() {
      _timerSeconds = 60;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Link Sent!!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // You can add any action here if needed
          },
        ),
      ),
    );
    _startTimer();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _resendTimer.cancel();
    super.dispose();
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
              'Enter the OTP sent to your email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const YMargin(height: 20),
            Text(
              'Enter the OTP sent to ${widget.email}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const YMargin(height: 20),
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.vpn_key),
                hintText: 'Enter OTP',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 50, color: Colors.black),
                ),
              ),
            ),
            const YMargin(height: 20),
            IndividualButton(
              buttonFunction: () => _verifyOTP(context),
              buttonText: 'Verify OTP',
              backgroundColor: const Color.fromRGBO(47, 78, 255, 0.8),
            ),
            // const YMargin(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Didn't receive the code?"),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.transparent;
                          },
                        ),
                      ),
                      onPressed: _timerSeconds > 0
                          ? null
                          : () {
                              // Implement logic to resend OTP
                              _resetTimer();
                            },
                      child: const Text('Resend code'),
                    ),
                  ],
                ),
                if (_timerSeconds > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.timer_outlined),
                      Text(
                        '$_timerSeconds s',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
