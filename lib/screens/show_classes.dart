import 'package:flutter/material.dart';
import 'package:manageit_school/controllers/controllers.dart';
import 'package:manageit_school/models/models.dart';
import 'package:manageit_school/screens/screens.dart';
import 'package:manageit_school/services/services.dart';
import 'package:manageit_school/utils/utils.dart';
import 'dart:math';

class ShowClassesScreen extends StatefulWidget {
  static const routeName = 'ShowClassesScreen';
  const ShowClassesScreen({super.key});

  @override
  State<ShowClassesScreen> createState() => _ShowClassesScreenState();
}

class _ShowClassesScreenState extends State<ShowClassesScreen>
    with TickerProviderStateMixin {
  List<Class>? classes;

  Future<List<Class>> loadClasses() async {
    final AuthController authController = AuthController();
    final String? userToken = await authController.getToken();

    if (userToken != null) {
      final List<Class>? result = await ApiService.fetchClasses(userToken);
      return result ?? [];
    } else {
      // Handle the case where userToken is null (user not logged in)
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Classes"),
      ),
      body: FutureBuilder<List<Class>>(
        future: loadClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text("Error loading classes"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No classes available"),
            );
          } else {
            classes = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const Text('Total Classes'),
                            Text(classes!.length.toString())
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ListView.builder(
                      itemCount: classes!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 1.0),
                            end: const Offset(0.0, 0.0),
                          ).animate(
                            CurvedAnimation(
                              curve: Curves.easeIn,
                              parent: AnimationController(
                                vsync: this,
                                duration: const Duration(milliseconds: 700),
                              )..forward(),
                            ),
                          ),
                          child: IndClassBox(indclass: classes![index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class IndClassBox extends StatelessWidget {
  final Class indclass;

  const IndClassBox({
    super.key,
    required this.indclass,
  });

  Color _getRandomPastelColor() {
    final List<Color> pastelColors = [
      const Color(0xFFB2CCFF),
      const Color(0xFFD1A7FF),
      const Color(0xFFFFC3A0),
      const Color(0xFFFFCB80),
      const Color(0xFFB2F7EF),
    ];
    return pastelColors[Random().nextInt(pastelColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    Color boxColor = _getRandomPastelColor();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: boxColor,
      ),
      child: ListTile(
        onTap: () {
          ManageItRouter.push(ShowClassStudentsScreen.routeName,
              arguments: indclass);
        },
        contentPadding: const EdgeInsets.all(10),
        style: ListTileStyle.list,
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          foregroundColor: boxColor,
          child: Text(
            indclass.className.substring(0, 1),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text(indclass.className),
        title: Text(
          indclass.classLongName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: indclass.schoolNotifications != null
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[350]!),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    indclass.schoolNotifications.toString(),
                    style: TextStyle(
                      color: boxColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
