import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/global_widgets.dart';
import 'package:manageit_school/screens/screens.dart';

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
