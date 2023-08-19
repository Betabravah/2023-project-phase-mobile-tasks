import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  CustomDateField(
      {super.key, required this.labelText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () => _selectDate(context),
          icon: const Icon(
            Icons.calendar_today,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = pickedDate.toString(); // Update the text field value
    }
  }
}
