import 'package:flutter/material.dart';
import 'package:manageit_school/controllers/auth_controller.dart';
import 'package:manageit_school/providers/user_provider.dart';
import 'package:manageit_school/screens/screens.dart';
import 'package:manageit_school/utils/manageit_router.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  final userDetails = await AuthController().fetchUserDetailsfromSP();
  final userToken = await AuthController().getToken();

  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          UserProvider()..setUserDetails(userDetails, userToken),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Manage!t School',
        home: const MyApp(),
        initialRoute: SplashScreen.routeName,
        navigatorKey: ManageItRouter.navigatorKey,
        routes: {
          DashBoard.routeName: (context) => const DashBoard(),
          AddStudentScreen.routeName: (context) => const AddStudentScreen(),
          EditStudentProfileScreen.routeName: (context) =>
              const EditStudentProfileScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          OverallAttendanceScreen.routeName: (context) =>
              const OverallAttendanceScreen(),
          // PaymentDetails.routeName: (context) => const PaymentDetails(),
          SearchStudentScreen.routeName: (context) =>
              const SearchStudentScreen(),
          ShowClassStudentsScreen.routeName: (context) =>
              const ShowClassStudentsScreen(),
          ShowClassesScreen.routeName: (context) => const ShowClassesScreen(),
          StudentProfileScreen.routeName: (context) =>
              const StudentProfileScreen(),
        },
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
