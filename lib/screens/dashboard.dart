import 'package:flutter/material.dart';
import 'package:manageit_school/constants/constants.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/models/models.dart';
import 'package:manageit_school/screens/student_profile.dart';

class DashBoard extends StatefulWidget {
  final Map<String, dynamic> user;
  const DashBoard({
    super.key,
    required this.user,
  });

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late List<List<dynamic>> finalDashboardMenu = [];
  final List<List<dynamic>> studentsMainBox = Constants().studentsMainBox;

  @override
  void initState() {
    List<dynamic> userRoles = widget.user['authorities'];
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

    super.initState();
  }

  final Student student = Student(
    firstName: 'John',
    lastName: 'Doe',
    rollNumber: '12345',
    phoneNumber: '1234567890',
    startDate: DateTime.now().toString(),
    addressLine1: '123 Main St',
    fatherName: 'John Doe Sr.',
    schoolClass: Class(
      id: 1,
      className: 'Class 10',
      classLongName: 'Class 10A',
      school: School(
        id: 1,
        groupName: 'School Group',
        schoolName: 'My School',
        tenant: Tenant(
          id: 1,
          tenantName: 'My Tenant',
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      Text(
                        'Hi ${widget.user['firstname']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Class XI - B | Roll No. 04',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 18,
                        ),
                      ),
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
                  GestureDetector(
                    onTap: () {
                      NavigatorWidget().screenReplacement(
                        context,
                        StudentProfileScreen(
                          student: student,
                        ),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -MediaQuery.of(context).size.height * 0.045),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Transform.translate(
                  offset: Offset(0, -MediaQuery.of(context).size.height * 0.12),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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

class DashBoardMainBox extends StatelessWidget {
  final String iconImage;
  final String title;
  final String? value;
  final Widget nextScreen;
  const DashBoardMainBox({
    super.key,
    required this.iconImage,
    required this.title,
    required this.nextScreen,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorWidget().screenReplacement(context, nextScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.black)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconImage,
              height: 60,
              width: 60,
            ),
            if (value != null)
              Text(
                value!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.arrow_forward_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashBoardMenu extends StatelessWidget {
  final String iconImage;
  final String title;
  final Widget nextScreen;
  const DashBoardMenu({
    super.key,
    required this.iconImage,
    required this.title,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorWidget().screenReplacement(context, nextScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconImage,
              height: 40,
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
