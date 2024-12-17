import 'package:campus_flow/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/library_controller.dart';
import '../../models/library_model.dart';
import '../../widgets/custom_textfield.dart';

class LibraryFormPage extends StatelessWidget {
  final LibraryModel? entry;

  LibraryFormPage({super.key, this.entry});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LibraryController>(context, listen: false);

    final idController = TextEditingController(text: entry?.entryId ?? '');
    final nameController = TextEditingController(text: entry?.name ?? '');
    final phoneNumberController =
        TextEditingController(text: entry?.phoneNumber ?? '');
    final bookTitleController =
        TextEditingController(text: entry?.bookTitle ?? '');
    final borrowDateController =
        TextEditingController(text: entry?.borrowDate ?? '');
    final returnDateController =
        TextEditingController(text: entry?.returnDate ?? '');
    final statusController = TextEditingController(text: entry?.status ?? '');

    void saveEntry() {
      if (_formKey.currentState!.validate()) {
        final newEntry = LibraryModel(
          entryId: idController.text,
          name: nameController.text,
          phoneNumber: phoneNumberController.text,
          bookTitle: bookTitleController.text,
          borrowDate: borrowDateController.text,
          returnDate: returnDateController.text,
          status: statusController.text,
        );

        if (entry == null) {
          provider.addLibraryEntry(newEntry);
        } else {
          provider.updateLibraryEntry(newEntry.entryId, newEntry.toMap());
        }
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(entry == null ? 'Add Library Entry' : 'Edit Library Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: idController,
                labelText: 'Entry ID',
                hintText: 'Enter the entry ID',
                prefixIcon: Icons.fingerprint,
                validator: (value) =>
                    value!.isEmpty ? 'Entry ID is required' : null,
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
                controller: phoneNumberController,
                labelText: 'Phone Number',
                hintText: 'Enter the phone number',
                prefixIcon: Icons.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Phone Number is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: bookTitleController,
                labelText: 'Book Title',
                hintText: 'Enter the book title',
                prefixIcon: Icons.book,
                validator: (value) =>
                    value!.isEmpty ? 'Book Title is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: borrowDateController,
                labelText: 'Borrow Date',
                hintText: 'Enter the borrow date',
                prefixIcon: Icons.calendar_today,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: returnDateController,
                labelText: 'Return Date',
                hintText: 'Enter the return date',
                prefixIcon: Icons.calendar_today,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: statusController,
                labelText: 'Status',
                hintText: 'Enter the status',
                prefixIcon: Icons.info,
              ),
              const SizedBox(height: 30),
              CustomElevatedButton(
                text: 'Save',
                onPressed: saveEntry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
