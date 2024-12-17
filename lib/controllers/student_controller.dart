import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

class StudentController with ChangeNotifier {
  final CollectionReference _studentsCollection =
      FirebaseFirestore.instance.collection('students');

  List<Student> _students = [];

  List<Student> get students => _students;

  // Fetch students from Firestore
  Future<void> fetchStudents() async {
    QuerySnapshot snapshot = await _studentsCollection.get();
    _students = snapshot.docs
        .map((doc) => Student.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  // Add a new student
  Future<void> addStudent(Student student) async {
    await _studentsCollection.doc(student.studentId).set(student.toMap());
    _students.add(student);
    notifyListeners();
  }

  // Update a student
  Future<void> updateStudent(
      String studentId, Map<String, dynamic> updatedData) async {
    await _studentsCollection.doc(studentId).update(updatedData);
    int index =
        _students.indexWhere((student) => student.studentId == studentId);
    if (index != -1) {
      _students[index] = Student.fromMap(updatedData);
    }
    notifyListeners();
  }

  // Delete a student
  Future<void> deleteStudent(String studentId) async {
    await _studentsCollection.doc(studentId).delete();
    _students.removeWhere((student) => student.studentId == studentId);
    notifyListeners();
  }

//search
  void searchStudents(String query) {
    if (query.isEmpty) {
      fetchStudents(); // Reload all students if search query is empty
    } else {
      _students = _students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

//sort
  void sortStudentsByName({bool ascending = true}) {
    _students.sort((a, b) =>
        ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    notifyListeners();
  }
}
