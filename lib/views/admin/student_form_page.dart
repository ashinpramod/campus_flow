import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/student_controller.dart';
import '../../models/student_model.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_elevated_button.dart';

class StudentFormScreen extends StatelessWidget {
  final Student? student;

  StudentFormScreen({super.key, this.student});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentController>(context, listen: false);

    final idController = TextEditingController(text: student?.studentId ?? '');
    final nameController = TextEditingController(text: student?.name ?? '');
    final emailController = TextEditingController(text: student?.email ?? '');
    final phoneController = TextEditingController(text: student?.phone ?? '');
    final addressController =
        TextEditingController(text: student?.address ?? '');
    final classNameController =
        TextEditingController(text: student?.className ?? '');

    void saveStudent() {
      if (_formKey.currentState!.validate()) {
        final newStudent = Student(
          studentId: idController.text,
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          address: addressController.text,
          className: classNameController.text,
        );

        if (student == null) {
          provider.addStudent(newStudent);
        } else {
          provider.updateStudent(newStudent.studentId, newStudent.toMap());
        }
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(student == null ? 'Add Student' : 'Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: idController,
                labelText: 'Student ID',
                hintText: 'Enter the student ID',
                prefixIcon: Icons.perm_identity,
                validator: (value) =>
                    value!.isEmpty ? 'Student ID is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: nameController,
                labelText: 'Name',
                hintText: 'Enter the name',
                prefixIcon: Icons.person,
                validator: (value) =>
                    value!.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: emailController,
                labelText: 'Email',
                hintText: 'Enter the email',
                prefixIcon: Icons.email,
                validator: (value) =>
                    value!.isEmpty ? 'Email is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: phoneController,
                labelText: 'Phone',
                hintText: 'Enter the phone number',
                prefixIcon: Icons.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Phone number is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: addressController,
                labelText: 'Address',
                hintText: 'Enter the address',
                prefixIcon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: classNameController,
                labelText: 'Class',
                hintText: 'Enter the class ',
                prefixIcon: Icons.class_,
              ),
              const SizedBox(height: 30),
              CustomElevatedButton(
                text: "Save",
                onPressed: saveStudent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
