import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/global_widgets.dart';
import 'package:manageit_school/screens/dashboard.dart';
import 'package:manageit_school/screens/login.dart';
import 'package:manageit_school/controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkUserLoggedIn();
    });
  }

  Future<void> checkUserLoggedIn() async {
    final AuthController authController = AuthController();
    final String? token = await authController.getToken();
    print('User token is');
    print(token);
    if (token != null) {
      // Fetch user information based on the token
      final Map<String, dynamic>? userDetails =
          await authController.fetchUserDetails(token);
      if (userDetails != null) {
        navigateToDashboard(userDetails);
      } else {
        navigateToLoginScreen();
      }
    } else {
      navigateToLoginScreen();
    }
  }

  void navigateToDashboard(Map<String, dynamic> user) {
    NavigatorWidget().screenPushReplacement(context, const DashBoard());
  }

  void navigateToLoginScreen() {
    NavigatorWidget().screenPushReplacement(context, const LoginScreen());
  }

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
}
