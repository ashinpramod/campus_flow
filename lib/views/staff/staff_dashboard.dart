import 'package:campus_flow/views/staff/staff_controlled_fees_history_screen.dart';
import 'package:campus_flow/views/staff/staff_controlled_library_history_page.dart';
import 'package:campus_flow/views/staff/staff_controlled_student_list_screen.dart';
import 'package:flutter/material.dart';

class StaffDashboard extends StatelessWidget {
  const StaffDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Dashboard'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const StaffControlledFeesHistoryPage()),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.blueAccent, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.attach_money, size: 24, color: Colors.blueAccent),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Manage Fees',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.blueAccent),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const StaffControlledLibraryHistoryPage()),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.blueAccent, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.library_books, size: 24, color: Colors.blueAccent),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Manage Library',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.blueAccent),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const StaffControlledStudentList()),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.blueAccent, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.school, size: 24, color: Colors.blueAccent),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Manage Students',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.blueAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
