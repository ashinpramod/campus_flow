// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   User? _user;
//   String _role = 'Student'; // Default role
//   User? get user => _user;

//   bool get isAuthenticated => _user != null;

//   String get role => _role;

//   Future<void> register(String email, String password, String role) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       _user = userCredential.user;

//       // Assign role during registration
//       _role = role;

//       notifyListeners();
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   Future<bool> login(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       _user = userCredential.user;

//       // Assign role based on email for demo
//       if (email.contains('staff')) {
//         _role = 'Staff';
//       } else if (email.contains('student')) {
//         _role = 'Student';
//       } else if (email.contains('admin')) {
//         _role = 'Admin';
//       }

//       notifyListeners();
//       return true;
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   Future<void> logout() async {
//     await _auth.signOut();
//     _user = null;
//     notifyListeners();
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  String _role = 'Student'; // Default role
  User? get user => _user;

  bool get isAuthenticated => _user != null;

  String get role => _role;

  /// Register user and store role in Firestore
  Future<void> register(String email, String password, String role) async {
    try {
      // Create user with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      // Save role in Firestore
      await _firestore.collection('users').doc(_user!.uid).set({
        'email': email,
        'role': role,
      });

      // Update local role state
      _role = role;

      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  /// Login user and fetch role from Firestore
  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      // Fetch role from Firestore
      if (_user != null) {
        DocumentSnapshot roleSnapshot =
            await _firestore.collection('users').doc(_user!.uid).get();

        if (roleSnapshot.exists) {
          _role = roleSnapshot['role'];
        } else {
          _role = 'Student'; // Default role if not found
        }
      }

      notifyListeners();
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Logout user
  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _role = 'Student'; // Reset role to default
    notifyListeners();
  }
}
