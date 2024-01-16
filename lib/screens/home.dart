import 'package:flutter/material.dart';
import 'package:manageit_school/screens/admin.dart';
import 'package:manageit_school/screens/dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage!t School'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Dashboard'),
              Tab(text: 'Admin'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
                child: DashBoard(user: {
              "id": 57302,
              "login": "nishant.ssik",
              "firstName": null,
              "lastName": null,
              "email": "nishant.ssik@gmail.com",
              "imageUrl": null,
              "activated": true,
              "langKey": "en",
              "createdBy": "nishant",
              "createdDate": "2023-12-27T17:07:59.577607Z",
              "lastModifiedBy": "nishant",
              "lastModifiedDate": "2023-12-27T17:10:26.334648Z",
              "authorities": [
                "ROLE_USER",
                "ROLE_SCHOOL_TEACHER",
                "ROLE_ADMIN",
                "ROLE_SCHOOL_ADMIN",
                "ROLE_SCHOOL_STUDENT"
              ]
            })),
            Center(child: AdminScreen()),
          ],
        ),
      ),
    );
  }
}
