import 'package:flutter/material.dart';
import 'package:manageit_school/screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 39, 194, 241),
              Color.fromARGB(255, 216, 78, 78)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Image.asset(
              //       'assets/images/Illustration.png',
              //       width: MediaQuery.of(context).size.width * 0.7,
              //     ),
              //   ],
              // ),
              Image.asset(
                'assets/images/logo_without_bg.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }
}
