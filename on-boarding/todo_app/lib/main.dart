import 'package:flutter/material.dart';

import 'feature/presentation/screens/add_task_screen.dart';
import 'feature/presentation/screens/home_screen.dart';
import 'core/theme.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Todo App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        // '/add': (context) => AddTaskScreen(),
        // '/view': (context) => ViewTaskScreen(),
      },
    );
  }
}
