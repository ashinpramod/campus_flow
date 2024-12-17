import 'package:campus_flow/views/student/fees_list_screen.dart';
import 'package:campus_flow/views/student/library_list_screen.dart';
import 'package:flutter/material.dart';
import 'student_list_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(//----------------------------------------------------student list screen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentListScreen(),
                  ),
                );
              },
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
                  Icon(Icons.person, size: 24, color: Colors.blueAccent),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'View Students Details',
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
            ElevatedButton(               //----------------------------------fees screen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentFeesListScreen(),
                  ),
                );
              },
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
                      'View Fees History',
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
            const SizedBox(height: 16),    //------------------------------library screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentLibraryScreen(),
                  ),
                );
              },
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
                      'View Library Records',
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
