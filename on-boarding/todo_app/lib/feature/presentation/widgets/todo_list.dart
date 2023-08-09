import 'package:flutter/material.dart';

import '../../domain/task.dart';
import '../screens/edit_task_screen.dart';

class TodoList extends StatefulWidget {
  final List<Task>? tasks;

  const TodoList(this.tasks);

  @override
  State<TodoList> createState() => _TodoListState(tasks);
}

class _TodoListState extends State<TodoList> {
  List<Task>? tasks;
  _TodoListState(this.tasks);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        height: 200.0,
      child: ListView.builder(
        itemCount: widget.tasks!.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(color: Colors.red[100]),
            key: Key(widget.tasks![index].title),
            direction: DismissDirection.horizontal, // Set the dismiss direction
            onDismissed: (direction) {
              setState(() {
                tasks!.removeAt(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 2.0,
                child: ListTile(
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskScreen(tasks![index]),
                        ),
                      ).then((editedTask) {
                        if (editedTask != null) {
                          setState(() {
                            tasks![index] = editedTask;
                          });
                        }
                      });
                    },
                  ),
                  title: Text(widget.tasks![index].title),
                  subtitle: Text(widget.tasks![index].description),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
