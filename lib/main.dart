import 'package:flutter/material.dart';
import 'package:manageit_school/controllers/auth_controller.dart';
import 'package:manageit_school/providers/user_provider.dart';
import 'package:manageit_school/screens/splash.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  final userDetails = await AuthController().fetchUserDetailsfromSP();
  final userToken = await AuthController().getToken();

  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          UserProvider()..setUserDetails(userDetails, userToken),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Manage!t School',
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
