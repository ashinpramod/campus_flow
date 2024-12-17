import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<String> roles = ['Staff', 'Student'];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? selectedRole;

    void registerUser() async {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (name.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
        return;
      }

      try {
        //------------------------------------------------------- Register the user with the selected role
        await authProvider.register(email, password, selectedRole!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')),
        );

        //----------------------------------------- Clear fields
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        selectedRole = null;

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register New User',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            //---------------------------------------------------------Input Fields
            CustomTextFormField(
              controller: nameController,
              labelText: 'Name',
              hintText: 'Enter your name',
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 25),

            CustomTextFormField(
              controller: emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 25),

           
            CustomTextFormField(
              controller: passwordController,
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 25),

            //-------------------------------------------------------------------- Role Selection Dropdown
            DropdownButtonFormField<String>(
              value: selectedRole,
              hint: const Text('Select Role'),
              items: roles
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (value) {
                selectedRole = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 2.0,
                  ),
                ),
                labelText: 'Role',
              ),
            ),
            const SizedBox(height: 40),

            //-------------------------------------------------------------- Register Button
            CustomElevatedButton(
              text: 'Register',
              onPressed: registerUser,
            ),
          ],
        ),
      ),
    );
  }
}
