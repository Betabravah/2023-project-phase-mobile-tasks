import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';
import 'package:todo_app_clean_architecture/core/usecases/usecase.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/usecases.dart' as usecases;

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/input_convertor.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final usecases.CreateTask createTask;
  final usecases.GetTask getTask;
  final usecases.ViewAllTasks getAllTasks;
  final usecases.EditTask updateTask;
  final usecases.RemoveTask deleteTask;

  final InputConverter inputConvertor;

  TaskBloc(
      {required this.createTask,
      required this.getTask,
      required this.getAllTasks,
      required this.updateTask,
      required this.deleteTask,
      required this.inputConvertor})
      : super(InitialState()) {
    //
    //
    on<LoadAllTasksEvent>((event, emit) async {
      emit(LoadingState());

      final result = await getAllTasks(NoParams());

      late TaskState state;

      result.fold((failure) {
        state = ErrorState(failure.message);
      }, (tasks) {
        state = LoadedAllTasksState(tasks);
      });

      emit(state);
    });

    on<GetSingleTaskEvent>((event, emit) async {
      emit(LoadingState());

      final result = await getTask(usecases.GetParams(id: event.id));

      late TaskState state;

      result.fold((failure) {
        state = ErrorState(failure.message);
      }, (task) {
        state = LoadedSingleTaskState(task);
      });
      emit(state);
    });

    on<CreateTaskEvent>((event, emit) async {
      emit(LoadingState());

      final parsedDate =
          inputConvertor.stringToDateTime(event.dueDate, future: true);

      parsedDate.fold(
          (failure) => emit(ErrorState(failure.message)), (right) => null);

      final task = Task(
          id: -1,
          title: event.title,
          description: event.description,
          isCompleted: false,
          dueDate: (parsedDate as Right).value);

      final result = await createTask(usecases.CreateParams(task: task));

      late TaskState state;

      result.fold((failure) {
        state = ErrorState(failure.message);
      }, (task) {
        state = CreatedTaskState(task);
      });
      emit(state);
    });

    on<UpdateTaskEvent>((event, emit) async {
      emit(LoadingState());

      final parsedDate =
          inputConvertor.stringToDateTime(event.dueDate, future: true);

      parsedDate.fold(
          (failure) => emit(ErrorState(failure.message)), (right) => null);

      final task = Task(
          id: -1,
          title: event.title,
          description: event.description,
          isCompleted: false,
          dueDate: (parsedDate as Right).value);

      final result = await updateTask(usecases.EditParams(task: task));

      late TaskState state;

      result.fold((failure) {
        state = ErrorState(failure.message);
      }, (task) {
        state = UpdatedTaskState(task);
      });
      emit(state);
    });

    on<DeleteTaskEvent>((event, emit) async {
      final result = await deleteTask(usecases.DeleteParams(id: event.id));

      late TaskState state;

      result.fold((failure) {
        state = ErrorState(failure.message);
      }, (task) {
        state = DeletedTaskState(task);
      });
      emit(state);
    });
  }
}
