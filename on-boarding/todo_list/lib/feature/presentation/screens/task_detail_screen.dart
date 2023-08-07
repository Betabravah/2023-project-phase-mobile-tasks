import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../widgets/task.dart';

class TaskDetalScreen extends StatelessWidget {
  const TaskDetalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                "Task Detail",
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
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(30),
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Image(
                              image: AssetImage('assets/images/tasks.png'),
                              width: 350)),
                      Text("Title", style: TextStyle(fontSize: 20)),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Task title",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 196, 196, 196),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Description", style: TextStyle(fontSize: 20)),
                      TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Task description",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 196, 196, 196),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Due Date", style: TextStyle(fontSize: 20)),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Task description",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 196, 196, 196),
                        ),
                      )
                    ]),
              ),
            )));
  }
}
