import 'package:campus_flow/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/fees_controller.dart';
import '../../models/fees_model.dart';
import '../../widgets/custom_textfield.dart';

class FeesFormScreen extends StatelessWidget {
  final FeeRecordModel? record;

  FeesFormScreen({super.key, this.record});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeesController>(context, listen: false);

    final idController = TextEditingController(text: record?.recordId ?? '');
    final nameController = TextEditingController(text: record?.name ?? '');
    final mobileNumberController =
        TextEditingController(text: record?.mobileNumber ?? '');
    final amountController =
        TextEditingController(text: record?.amount.toString() ?? '');
    final dueDateController =
        TextEditingController(text: record?.dueDate ?? '');
    final statusController = TextEditingController(text: record?.status ?? '');

    void saveRecord() {
      if (_formKey.currentState!.validate()) {
        final newRecord = FeeRecordModel(
          recordId: idController.text,
          name: nameController.text,
          mobileNumber: mobileNumberController.text,
          amount: double.parse(amountController.text),
          dueDate: dueDateController.text,
          status: statusController.text,
        );

        if (record == null) {
          provider.addFeeRecord(newRecord);
        } else {
          provider.updateFeeRecord(newRecord.recordId, newRecord.toMap());
        }
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(record == null ? 'Add Fee Record' : 'Edit Fee Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: idController,
                labelText: 'Record ID',
                hintText: 'Enter the record ID',
                prefixIcon: Icons.fingerprint,
                validator: (value) =>
                    value!.isEmpty ? 'Record ID is required' : null,
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
                controller: mobileNumberController,
                labelText: 'Mobile Number',
                hintText: 'Enter the mobile number',
                prefixIcon: Icons.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Mobile Number is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: amountController,
                labelText: 'Amount',
                hintText: 'Enter the amount',
                prefixIcon: Icons.attach_money,
                validator: (value) =>
                    value!.isEmpty ? 'Amount is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: dueDateController,
                labelText: 'Due Date',
                hintText: 'Enter the due date',
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
                text: "Save",
                onPressed: saveRecord,
              )
            ],
          ),
        ),
      ),
    );
  }
}

