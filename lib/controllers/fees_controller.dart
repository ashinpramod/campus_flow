import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/fees_model.dart';

class FeesController with ChangeNotifier {
  final CollectionReference _feesCollection =
      FirebaseFirestore.instance.collection('fee_records');

  List<FeeRecordModel> _records = [];

  List<FeeRecordModel> get records => _records;

  // Fetch all fee records
  Future<void> fetchFeeRecords() async {
    QuerySnapshot snapshot = await _feesCollection.get();
    _records = snapshot.docs
        .map(
            (doc) => FeeRecordModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  // Add a new fee record
  Future<void> addFeeRecord(FeeRecordModel record) async {
    await _feesCollection.doc(record.recordId).set(record.toMap());
    _records.add(record);
    notifyListeners();
  }

  // Update an existing fee record
  Future<void> updateFeeRecord(
      String recordId, Map<String, dynamic> updatedData) async {
    await _feesCollection.doc(recordId).update(updatedData);
    int index = _records.indexWhere((record) => record.recordId == recordId);
    if (index != -1) {
      _records[index] = FeeRecordModel.fromMap(updatedData);
    }
    notifyListeners();
  }

  // Delete a fee record
  Future<void> deleteFeeRecord(String recordId) async {
    await _feesCollection.doc(recordId).delete();
    _records.removeWhere((record) => record.recordId == recordId);
    notifyListeners();
  }
  //search

  void searchFeeRecords(String query) {
    if (query.isEmpty) {
      fetchFeeRecords(); 
    } else {
      _records = _records
          .where((record) =>
              record.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

//sort
  void sortFeeRecordsByName({bool ascending = true}) {
    _records.sort((a, b) =>
        ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    notifyListeners();
  }
}

