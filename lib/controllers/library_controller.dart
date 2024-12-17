import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/library_model.dart';

class LibraryController with ChangeNotifier {
  final CollectionReference _libraryCollection =
      FirebaseFirestore.instance.collection('library_entries');

  List<LibraryModel> _entries = [];

  List<LibraryModel> get entries => _entries;

  // Fetch all library entries
  Future<void> fetchLibraryEntries() async {
    QuerySnapshot snapshot = await _libraryCollection.get();
    _entries = snapshot.docs
        .map((doc) => LibraryModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  // Add a new library entry
  Future<void> addLibraryEntry(LibraryModel entry) async {
    await _libraryCollection.doc(entry.entryId).set(entry.toMap());
    _entries.add(entry);
    notifyListeners();
  }

  // Update an existing library entry
  Future<void> updateLibraryEntry(
      String entryId, Map<String, dynamic> updatedData) async {
    await _libraryCollection.doc(entryId).update(updatedData);
    int index = _entries.indexWhere((entry) => entry.entryId == entryId);
    if (index != -1) {
      _entries[index] = LibraryModel.fromMap(updatedData);
    }
    notifyListeners();
  }

  // Delete a library entry
  Future<void> deleteLibraryEntry(String entryId) async {
    await _libraryCollection.doc(entryId).delete();
    _entries.removeWhere((entry) => entry.entryId == entryId);
    notifyListeners();
  }

// search
  void searchLibraryEntries(String query) {
    if (query.isEmpty) {
      // Reset to all entries if query is empty
      fetchLibraryEntries();
    } else {
      _entries = _entries
          .where(
              (entry) => entry.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

//sort
  void sortLibraryEntriesByName({bool ascending = true}) {
    _entries.sort((a, b) =>
        ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    notifyListeners();
  }
}
