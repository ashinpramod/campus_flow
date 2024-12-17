import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controllers.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthControllers>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                "assets/images/16191.jpg",
                height: 250,
                width: 300,
                fit: BoxFit.contain,
              ),

              // App Title
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please sign in to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),

              // Email Input Field
              CustomTextFormField(
                controller: authController.emailController,
                labelText: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 16),

              // Password Input Field
              CustomTextFormField(
                  controller: authController.passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  prefixIcon: Icons.lock),
              const SizedBox(height: 24),

              CustomElevatedButton(
                text: 'Login',
                onPressed: () async {
                  final email = authController.emailController.text.trim();
                  final password =
                      authController.passwordController.text.trim();

                  // Check for Admin Login
                  if (email.toLowerCase() ==
                          authController.adminEmail.toLowerCase() &&
                      password == authController.adminPassword) {
                    authController.resetControllers(); // Clear fields

                    Navigator.pushNamed(context, '/admin_dashboard');
                    return;
                  }

                  // Authenticate User
                  try {
                    final isAuthenticated =
                        await authProvider.login(email, password);

                    if (isAuthenticated) {
                      authController.resetControllers(); // Clear fields
                      // Navigate based on role
                      switch (authProvider.role) {
                        case 'Admin':
                          Navigator.pushNamed(context, '/admin_dashboard');
                          break;
                        case 'Staff':
                          Navigator.pushNamed(context, '/staff_dashboard');
                          break;
                        case 'Student':
                          Navigator.pushNamed(context, '/student_dashboard');
                          break;
                        default:
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid role')),
                          );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid credentials')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
              ),

              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}


