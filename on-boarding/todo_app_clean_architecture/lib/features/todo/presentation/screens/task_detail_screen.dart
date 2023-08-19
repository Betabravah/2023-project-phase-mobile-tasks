import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/input_convertor.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/show_status.dart';
import '../widgets/task_feature_container.dart';

class TaskDetailScreen extends StatelessWidget {
  final int taskId;

  const TaskDetailScreen(this.taskId, {super.key});

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
          title: const Center(
            child: Text('Task Detail'),
          ),
        ),
        body: BlocProvider(
          create: (context) =>
              serviceLocator<TaskBloc>()..add(GetSingleTaskEvent(id: taskId)),
          child: BlocConsumer<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is UpdatedTaskState) {
                final message =
                    state.task.isCompleted ? 'complete' : 'incomplete';
                showSuccess(context, 'Task marked as $message');
                Navigator.of(context).pop();
              } else if (state is DeletedTaskState) {
                showSuccess(context, 'Task deleted successfully');
                Navigator.of(context).pop();
              } else if (state is ErrorState) {
                showError(context, state.message);
              }
            },
            buildWhen: (previous, current) => current is! ErrorState,
            builder: (context, state) {
              if (state is LoadedSingleTaskState) {
                return Container(
                  child: buildBody(context, state.task),
                );
              }
              return const LoadingWidget();
            },
          ),
        ));
  }

  Widget buildBody(BuildContext context, Task task) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
            child: Image.asset(
              'assets/images/tasks.png',
            ),
          ),

          //
          const SizedBox(height: 30),
          TaskFeatureContainer(title: 'Title', feature: task.title),

          //
          const SizedBox(height: 20),
          TaskFeatureContainer(title: 'Description', feature: task.description),

          //
          const SizedBox(height: 20),
          TaskFeatureContainer(
              title: 'Deadline',
              feature: serviceLocator<InputConverter>()
                  .dateTimeToString(task.dueDate)),
        ],
      ),
    );
  }
}
