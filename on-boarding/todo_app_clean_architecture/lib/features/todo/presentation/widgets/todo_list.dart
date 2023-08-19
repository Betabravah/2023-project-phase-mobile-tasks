import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';

class TodoList extends StatefulWidget {
  final List<Task>? tasks;

  const TodoList(this.tasks, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<TodoList> createState() => _TodoListState(tasks);
}

class _TodoListState extends State<TodoList> {
  List<Task>? tasks;
  _TodoListState(this.tasks);
  @override
  Widget build(BuildContext context) {
    if (widget.tasks!.isEmpty) {
      return const Center(
        child: Text('No tasks found, please add some tasks'),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: 200.0,
      child: ListView.builder(
        itemCount: widget.tasks!.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              color: Colors.red[100],
              child: const Row(
                children: [
                  Expanded(child: SizedBox()),
                  Text('Delete Task'),
                  SizedBox(width: 50),
                ],
              ),
            ),
            key: Key(widget.tasks![index].title),
            direction: DismissDirection.horizontal, // Set the dismiss direction
            onDismissed: (direction) async {
              Task task = widget.tasks!.removeAt(index);
              BlocProvider.of<TaskBloc>(context)
                  .add(DeleteTaskEvent(id: task.id));
            },
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/task-detail',
                  arguments: widget.tasks![index].id,
                ).then((editedTask) {
                  BlocProvider.of<TaskBloc>(context).add(LoadAllTasksEvent());
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 2.0,
                  child: ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/add',
                          arguments: widget.tasks![index],
                        ).then((editedTask) {
                          BlocProvider.of<TaskBloc>(context)
                              .add(LoadAllTasksEvent());
                        });
                      },
                    ),
                    title: Text(widget.tasks![index].title),
                    subtitle: Text(widget.tasks![index].description),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
