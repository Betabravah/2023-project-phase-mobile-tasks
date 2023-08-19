import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_clean_architecture/injection_container.dart';

import '../bloc/task_bloc.dart';
import '../widgets/show_status.dart';
import '../widgets/todo_list.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Your tasks'),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            serviceLocator<TaskBloc>()..add(LoadAllTasksEvent()),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, _) => buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    print('....');
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Image.asset('assets/images/todo.png', width: 250),
          ),
          SizedBox(
            height: 400,
            child: BlocConsumer<TaskBloc, TaskState>(
              listener: (context, state) {
                if (state is ErrorState) {
                  showError(context, state.message);
                  debugPrint(state.message);
                } else if (state is DeletedTaskState) {
                  showSuccess(context, 'Task deleted successfully');
                  context.read<TaskBloc>().add(LoadAllTasksEvent());
                }
              },
              builder: (context, state) {
                if (state is LoadedAllTasksState) {
                  return TodoList(state.tasks);
                } else if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                //
                return const Text('hiii');
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  '/add',
                );
                if (mounted) {
                  context.read<TaskBloc>().add(LoadAllTasksEvent());
                }
              },
              child: const Text("Add Task")),
        ],
      ),
    );
  }
}
