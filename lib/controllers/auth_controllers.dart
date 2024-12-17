import 'package:flutter/material.dart';

class AuthControllers extends ChangeNotifier {
  // Form Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Default admin credentials
  final String adminEmail = "admin@gmail.com";
  final String adminPassword = "admin123";

  // Getters
  String get email => emailController.text;
  String get password => passwordController.text;

  void resetControllers() {
    emailController.clear();
    passwordController.clear();
  }
}


