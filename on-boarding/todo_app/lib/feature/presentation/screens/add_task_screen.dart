import 'package:flutter/material.dart';

import '../../domain/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text =
            pickedDate.toString(); // Update the text field value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('New Task'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
                image: AssetImage('assets/images/splash_screen.png'),
                width: 350),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                key: const Key('title_text_field'),
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                key: const Key('description_text_field'),
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                key: const Key('date_text_field'),
                controller: _dateController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Date',
                  suffixIcon: GestureDetector(
                    key: const Key('date_picker_icon'),
                    onTap: _selectDate, // Show the date picker on tap
                    child: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                key: const Key('priority_text_field'),
                controller: _priorityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'priority',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint("Add Task");
                final String title = _titleController.text;
                final String description = _descriptionController.text;
                final String date = _dateController.text;
                final String priority = _priorityController.text;
                debugPrint(title);

                final Task newTask = Task(
                    title: title,
                    description: description,
                    date: DateTime.parse(date),
                    priority: int.parse(priority));
                Navigator.pop(context, newTask);
              },
              child: const Text("Add Task"),
            )
          ],
        ),
      ),
    );
  }
}
