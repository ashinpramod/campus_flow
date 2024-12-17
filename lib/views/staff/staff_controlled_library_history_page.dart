import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/library_controller.dart';
import 'library_form_screen.dart';

class StaffControlledLibraryHistoryPage extends StatelessWidget {
  const StaffControlledLibraryHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final libraryController =
        Provider.of<LibraryController>(context, listen: false);

    void performSearch(String query) {
      libraryController.searchLibraryEntries(query);
    }

    void sortLibraryEntries(bool ascending) {
      libraryController.sortLibraryEntriesByName(ascending: ascending);
    }

    bool isAscending = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Library History'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(
              isAscending ? Icons.sort_by_alpha : Icons.sort,
              color: Colors.white,
            ),
            tooltip: 'Sort by Borrow Date',
            onPressed: () {
              isAscending = !isAscending;
              sortLibraryEntries(isAscending);
            },
          ),
        ],
      ),
      body: Column(
        children: [
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
          Expanded(
            child: FutureBuilder(
              future: libraryController.fetchLibraryEntries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Failed to load library entries. Please try again later.',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  );
                }

                return Consumer<LibraryController>(
                  builder: (context, provider, child) {
                    if (provider.entries.isEmpty) {
                      return const Center(
                        child: Text(
                          'No library entries available.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.entries.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      itemBuilder: (context, index) {
                        final entry = provider.entries[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        entry.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blueAccent),
                                          tooltip: 'Edit Entry',
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LibraryFormPage(
                                                        entry: entry),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          tooltip: 'Delete Entry',
                                          onPressed: () {
                                            _showDeleteConfirmationDialog(
                                                context, entry);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Phone Number: ${entry.phoneNumber}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Book Title: ${entry.bookTitle}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Borrow Date: ${entry.borrowDate}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Return Date: ${entry.returnDate}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Status: ${entry.status}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LibraryFormPage(),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        tooltip: 'Add Library Entry',
        child: const Icon(Icons.add),
      ),
    );
  }



  void _showDeleteConfirmationDialog(BuildContext context, entry) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Library Entry'),
        content: Text('Are you sure you want to delete ${entry.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<LibraryController>(context, listen: false)
                  .deleteLibraryEntry(entry.entryId); // Corrected here
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

}
