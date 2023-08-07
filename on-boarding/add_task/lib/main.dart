import 'package:add_task/feature/presentation/screens/get_started_screen.dart';
import 'package:flutter/material.dart';

import 'feature/presentation/screens/add_task_screen.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/addtask': (context) =>
          AddTaskScreen(), // Define the route for the second screen
    },
    home: GetStartedScreen(),
  ));
}
