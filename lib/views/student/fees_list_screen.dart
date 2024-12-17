import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_flow/controllers/fees_controller.dart';

class StudentFeesListScreen extends StatelessWidget {
  const StudentFeesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final feesController = Provider.of<FeesController>(context, listen: false);

    void performSearch(String query) {
      feesController.searchFeeRecords(query);
    }

    void sortRecords(bool ascending) {
      feesController.sortFeeRecordsByName(ascending: ascending);
    }

    bool isAscending = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fees History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(isAscending ? Icons.sort_by_alpha : Icons.sort,
                color: Colors.white),
            tooltip: 'Sort by Name',
            onPressed: () {
              isAscending = !isAscending;
              sortRecords(isAscending);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          //-----------------------------------------------------Search Bar
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
          //--------------------------------------------------------------------------- FutureBuilder and List
          Expanded(
            child: FutureBuilder(
              future: feesController.fetchFeeRecords(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator(color: Colors.blueAccent));
                }

                return Consumer<FeesController>(
                  builder: (context, provider, child) {
                    if (provider.records.isEmpty) {
                      return const Center(
                        child: Text(
                          'No fee records available.',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.records.length,
                      itemBuilder: (context, index) {
                        final record = provider.records[index];
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
                              record.name,
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
                                    'Mobile Number: ${record.mobileNumber}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Amount: \$${record.amount}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Due Date: ${record.dueDate}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Status: ${record.status}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
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
