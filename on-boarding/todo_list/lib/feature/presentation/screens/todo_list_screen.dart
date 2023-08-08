import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../widgets/task.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                "Todo List",
                style: TextStyle(color: Colors.black),
              )),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: primaryColor,
                ),
                onPressed: () {
                  // Navigator.pop(context);
                },
              ),
              actions: const [Icon(Icons.more_vert, color: grey300, size: 40)],
              elevation: 0.0,
              backgroundColor: secondaryColor,
            ),
            body: Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Center(
                      child: Image(
                        image: AssetImage('assets/images/todo.png'),
                        width: 250,
                      ),
                    ),
                    const Text(
                      "Tasks",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Task("UI/UX App Design", DateTime.now(), 3),
                    Task("UI/UX App Design", DateTime.now(), 1),
                    Task("View Candidates", DateTime.now(), 2),
                    Task("Football Cu Dryblling", DateTime.now(), 3),
                  ]),
            )));
  }
}