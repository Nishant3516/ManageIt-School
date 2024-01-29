import 'package:flutter/material.dart';
import 'package:manageit_school/screens/screens.dart';
import 'package:manageit_school/controllers/controllers.dart';
import 'package:manageit_school/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'SplashScreen';
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
    ManageItRouter.pushNewStack(DashBoard.routeName);
  }

  void navigateToLoginScreen() {
    ManageItRouter.pushNewStack(DashBoard.routeName);
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
