import 'package:flutter/material.dart';
import 'package:manageit_school/screens/dashboard.dart'; // Import your dashboard screen
import 'package:manageit_school/screens/onboarding.dart';
import 'package:manageit_school/controllers/auth_controller.dart';

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
              Color.fromARGB(255, 216, 78, 78),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    final AuthController authController = AuthController();
    final String? token = await authController.getToken();

    if (token != null) {
      // Fetch user information based on the token
      final Map<String, dynamic>? userDetails =
          await authController.fetchUserDetails(token);

      // User is logged in, navigate to the dashboard with user information
      navigateToDashboard(userDetails);
    } else {
      // User is not logged in, navigate to the onboarding screen
      navigateToOnboarding();
    }
  }

  void navigateToDashboard(Map<String, dynamic>? user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashBoard(user: user!),
      ),
    );
  }

  void navigateToOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }
}
