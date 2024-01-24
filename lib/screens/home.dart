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
            Center(child: DashBoard()),
            Center(child: AdminScreen()),
          ],
        ),
      ),
    );
  }
}
