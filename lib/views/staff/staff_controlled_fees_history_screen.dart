import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fees_form_screen.dart';
import '../../controllers/fees_controller.dart';
import '../../widgets/confirmation_dialog.dart';

class StaffControlledFeesHistoryPage extends StatelessWidget {
  const StaffControlledFeesHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final feesController = Provider.of<FeesController>(context, listen: false);

    void performSearch(String query) {
      feesController.searchFeeRecords(query);
    }

    void sortFees(bool ascending) {
      feesController.sortFeeRecordsByName(ascending: ascending);
    }

    bool isAscending = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fees History',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          // Sort Button
          IconButton(
            icon: Icon(
              isAscending ? Icons.sort_by_alpha : Icons.sort,
              color: Colors.white,
            ),
            tooltip: 'Sort by Amount',
            onPressed: () {
              isAscending = !isAscending;
              sortFees(isAscending);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
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

          // Fees Records
          Expanded(
            child: FutureBuilder(
              future: feesController.fetchFeeRecords(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Failed to load fee records. Please try again later.',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  );
                }

                return Consumer<FeesController>(
                  builder: (context, provider, child) {
                    if (provider.records.isEmpty) {
                      return const Center(
                        child: Text(
                          'No fee records available.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.records.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      itemBuilder: (context, index) {
                        final record = provider.records[index];
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
                                  children: [
                                    Expanded(
                                      child: Text(
                                        record.name,
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
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blueAccent,
                                          ),
                                          tooltip: 'Edit Fee Record',
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FeesFormScreen(
                                                        record: record),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          tooltip: 'Delete Fee Record',
                                          onPressed: () {
                                            _showDeleteConfirmationDialog(
                                                context, record);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Mobile Number: ${record.mobileNumber}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Amount: \$${record.amount}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Due Date: ${record.dueDate}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Status: ${record.status}',
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
              builder: (context) => FeesFormScreen(),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        tooltip: 'Add Fee Record',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, record) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: 'Delete Fee Record',
          content: 'Are you sure you want to delete ${record.name}?',
          onConfirm: () {
            Provider.of<FeesController>(context, listen: false)
                .deleteFeeRecord(record.recordId);
            Navigator.of(context).pop(); // Close the dialog
          },
          onCancel: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }
}



