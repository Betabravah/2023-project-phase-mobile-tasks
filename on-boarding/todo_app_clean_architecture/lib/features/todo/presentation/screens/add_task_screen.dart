import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../widgets/custom_date_field.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/show_status.dart';

class AddTaskScreen extends StatelessWidget {
  final Task? task;
  AddTaskScreen(this.task, {Key? key}) : super(key: key) {
    if (task != null) {
      _titleController.text = task!.title;
      _descriptionController.text = task!.description;
      _dateController.text = task!.dueDate.toString();
      _completedController.text = task!.isCompleted.toString();
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _completedController = TextEditingController();

  void dispatchCreate(BuildContext context) {
    BlocProvider.of<TaskBloc>(context).add(CreateTaskEvent(
      title: _titleController.text,
      description: _descriptionController.text,
      dueDate: _dateController.text,
    ));
  }

  void dispatchUpdate(BuildContext context) {
    BlocProvider.of<TaskBloc>(context).add(UpdateTaskEvent(
      id: task!.id,
      title: _titleController.text,
      description: _descriptionController.text,
      dueDate: _dateController.text,
      isCompleted: task!.isCompleted,
    ));
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
        title: Center(
          child: Text(task == null ? 'New Task' : 'Update Task'),
        ),
      ),
      body: BlocProvider(
        create: (_) => serviceLocator<TaskBloc>(),
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is ErrorState) {
              showError(context, state.message);
            }

            // updated
            else if (state is UpdatedTaskState) {
              showSuccess(context, 'Task updated successfully');
              Navigator.of(context).pop();
            }

            // created
            else if (state is CreatedTaskState) {
              showSuccess(context, 'Task created successfully');
              Navigator.of(context).pop();
            }
          },

          //
          builder: (context, state) => buildForm(context),
        ),
      ),
    );
  }

  Widget buildForm(context) {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height * .8,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Image(
              image: AssetImage('assets/images/add-task.png'), width: 250),

          //
          CustomTextField(
            labelText: 'Title',
            controller: _titleController,
          ),

          //
          CustomTextField(
            labelText: 'Description',
            controller: _descriptionController,
          ),

          //
          CustomDateField(
            labelText: 'Due Date',
            controller: _dateController,
          ),

          //
          CustomTextField(
            labelText: 'Completed',
            controller: _completedController,
          ),

          //
          ElevatedButton(
            onPressed: () => task != null
                ? dispatchUpdate(context)
                : dispatchCreate(context),
            child: Text(
              task != null ? 'Update task' : 'Add task',
            ),
          )
        ],
      ),
    ));
  }
}
