import 'package:flutter/material.dart';
import 'package:todo_app/feature/presentation/screens/add_task_screen.dart';

import '../widgets/todo_list.dart';
import '../../domain/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Your tasks'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset('assets/images/todo.png', width: 250),
            ),
            SizedBox(
              height: 400,
              child: TodoList(tasks),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskScreen(),
                  ),
                ).then((addedTask) {
                  if (addedTask != null) {
                    setState(() {
                      tasks.add(addedTask);
                    });
                  }
                });
              },
              child: const Text("Add Task"),
            )
          ],
        ),
      ),
    );
  }
}
