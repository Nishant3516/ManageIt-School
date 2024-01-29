import 'package:flutter/material.dart';
import 'package:manageit_school/constants/constants.dart';
import 'package:manageit_school/controllers/auth_controller.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/models/models.dart';
import 'package:manageit_school/providers/user_provider.dart';
import 'package:manageit_school/screens/login.dart';
import 'package:manageit_school/screens/student_profile.dart';
import 'package:manageit_school/utils/manageit_router.dart';
import 'package:manageit_school/widgets/dashboard_main_box.dart';
import 'package:manageit_school/widgets/dashboard_menu.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  static const routeName = 'DashBoard';
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Map<String, dynamic>? user;
  late List<List<dynamic>> finalDashboardMenu = [];
  final List<List<dynamic>> studentsMainBox = Constants().studentsMainBox;
  late bool isUserStudent;

  @override
  void didChangeDependencies() {
    isUserStudent = Provider.of<UserProvider>(context).isUserStudent();
    user = Provider.of<UserProvider>(context).userDetails;
    if (user != null) {
      List<dynamic> userRoles = user!['authorities'];
      print(user);
      if (userRoles.contains('ROLE_ADMIN')) {
        finalDashboardMenu = Constants().adminDashboardMenu;
      } else if (userRoles.contains('ROLE_SCHOOL_ACCOUNTANT')) {
        finalDashboardMenu = Constants().accountantDashboardMenu;
      } else if (userRoles.contains('ROLE_SCHOOL_TEACHER')) {
        finalDashboardMenu = Constants().schoolTeacherDashboardMenu;
      } else if (userRoles.contains('ROLE_SCHOOL_STUDENT')) {
        finalDashboardMenu = Constants().studentsDashboardMenu;
      } else {
        // Handle the case when the user has no recognized roles
        print('No recognized role');
        // Set a basic menu or display an error message
        finalDashboardMenu = Constants().studentsDashboardMenu;
      }
    }

    super.didChangeDependencies();
  }

  void handleLogout() async {
    // NavigatorWidget().screenPushReplacement(context, LoginScreen());
    ManageItRouter.pushNewStack(LoginScreen.routeName);
    await AuthController().clearUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: handleLogout,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: (user == null)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    padding: const EdgeInsets.only(bottom: 150, top: 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(114, 146, 207, 1),
                          Color.fromRGBO(67, 107, 186, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            YMargin(
                              height: MediaQuery.sizeOf(context).height * 0.05,
                            ),
                            Text(
                              'Hi, ${user!['firstname'] ?? 'admin'}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!isUserStudent)
                              const Text(
                                'Welcome to Manage!t School Admin Control',
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (isUserStudent)
                              Text(
                                'Class XI - B | Roll No. 04',
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 18,
                                ),
                              ),
                            if (isUserStudent)
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  '2020 - 2021',
                                  style: TextStyle(
                                    color: Color.fromRGBO(67, 107, 186, 1),
                                  ),
                                ),
                              )
                          ],
                        ),
                        // if (isUserStudent)
                        //   GestureDetector(
                        //     onTap: () {
                        //       NavigatorWidget().screenReplacement(
                        //         context,
                        //         StudentProfileScreen(
                        //           // student: Student.fromJson(user!),
                        //           studentId: student.id!,
                        //         ),
                        //       );
                        //     },
                        //     child: Container(
                        //       height: 70,
                        //       width: 70,
                        //       decoration: const BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset:
                        Offset(0, -MediaQuery.of(context).size.height * 0.045),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Transform.translate(
                        offset: Offset(
                            0, -MediaQuery.of(context).size.height * 0.12),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 0.9,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: studentsMainBox.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return DashBoardMainBox(
                                    iconImage: studentsMainBox[index][0],
                                    title: studentsMainBox[index][1],
                                    value: studentsMainBox[index][2],
                                    nextScreen: studentsMainBox[index][3],
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 1.3,
                                ),
                                itemCount: finalDashboardMenu.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return DashBoardMenu(
                                    iconImage: finalDashboardMenu[index][0],
                                    title: finalDashboardMenu[index][1],
                                    nextScreen: finalDashboardMenu[index][2],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
