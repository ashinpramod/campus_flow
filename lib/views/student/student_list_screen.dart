import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/student_controller.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final studentController =
        Provider.of<StudentController>(context, listen: false);

    void performSearch(String query) {
      studentController.searchStudents(query);
    }

    void sortStudents(bool ascending) {
      studentController.sortStudentsByName(ascending: ascending);
    }

    bool isAscending = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          //--------------------------------------------------------- Sort Button
          IconButton(
            icon: Icon(
              isAscending ? Icons.sort_by_alpha : Icons.sort,
              color: Colors.white,
            ),
            tooltip: 'Sort by Name',
            onPressed: () {
              isAscending = !isAscending;
              sortStudents(isAscending);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ---------------------------------------------------Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.3),
                    Colors.blueAccent.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: searchController,
                onChanged: performSearch,
                decoration: InputDecoration(
                  hintText: 'Search by Name',
                  hintStyle: const TextStyle(color: Colors.blueGrey),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.blueAccent),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon:
                              const Icon(Icons.clear, color: Colors.blueAccent),
                          onPressed: () {
                            searchController.clear();
                            performSearch('');
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),

          //----------------------------------------------------------- Student List
          Expanded(
            child: FutureBuilder(
              future: studentController.fetchStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blueAccent),
                  );
                }

                return Consumer<StudentController>(
                  builder: (context, provider, child) {
                    if (provider.students.isEmpty) {
                      return const Center(
                        child: Text(
                          'No students available.',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.students.length,
                      itemBuilder: (context, index) {
                        final student = provider.students[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            title: Text(
                              student.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blueAccent,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Class: ${student.className}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  Text(
                                    'Email: ${student.email}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  Text(
                                    'Phone: ${student.phone}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  Text(
                                    'Address: ${student.address}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
