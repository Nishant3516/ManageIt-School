import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/screens/add_student.dart';
import 'package:manageit_school/screens/search_student_screen.dart';
import 'package:manageit_school/screens/show_classes.dart';
import 'package:manageit_school/screens/student_payement_search.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen to search student details
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchStudentScreen(),
                  ),
                );
              },
              child: const Text('Search Student Details'),
            ),
            const YMargin(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddStudentScreen(),
                  ),
                );
              },
              child: const Text('Add Student'),
            ),
            const YMargin(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ShowClassesScreen(),
                  ),
                );
              },
              child: const Text('Manage Classes'),
            ),
            const YMargin(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const StudentPaymentSearchScreen(),
                  ),
                );
              },
              child: const Text('Manage Payments'),
            ),
          ],
        ),
      ),
    );
  }
}
