import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/library_controller.dart';

class StudentLibraryScreen extends StatelessWidget {
  const StudentLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final libraryController =
        Provider.of<LibraryController>(context, listen: false);

    void performSearch(String query) {
      libraryController.searchLibraryEntries(query);
    }

    void sortEntries(bool ascending) {
      libraryController.sortLibraryEntriesByName(ascending: ascending);
    }

    bool isAscending = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Library History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          //---------------------------------------------------------------- Sort Icon Button
          IconButton(
            icon: Icon(isAscending ? Icons.sort_by_alpha : Icons.sort,
                color: Colors.white),
            tooltip: 'Sort by Name',
            onPressed: () {
              isAscending = !isAscending;
              sortEntries(isAscending);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          //---------------------------------------------------------------- Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.3),
                    Colors.blueAccent.withOpacity(0.1)
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
          //---------------------------------------------------------------------- FutureBuilder and List
          Expanded(
            child: FutureBuilder(
              future: libraryController.fetchLibraryEntries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator(color: Colors.blueAccent));
                }

                return Consumer<LibraryController>(
                  builder: (context, provider, child) {
                    if (provider.entries.isEmpty) {
                      return const Center(
                        child: Text(
                          'No library entries available.',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.entries.length,
                      itemBuilder: (context, index) {
                        final entry = provider.entries[index];
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
                              entry.name,
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
                                    'Phone Number: ${entry.phoneNumber}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  Text(
                                    'Book Title: ${entry.bookTitle}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  Text(
                                    'Borrow Date: ${entry.borrowDate}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  Text(
                                    'Return Date: ${entry.returnDate}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  Text(
                                    'Status: ${entry.status}',
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
