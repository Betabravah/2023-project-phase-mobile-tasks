part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

final class InitialState extends TaskState {}

final class LoadingState extends TaskState {}

final class LoadedSingleTaskState extends TaskState {
  final Task task;

  const LoadedSingleTaskState(this.task);

  @override
  List<Object?> get props => [task];
}

final class LoadedAllTasksState extends TaskState {
  final List<Task> tasks;

  const LoadedAllTasksState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

final class CreatedTaskState extends TaskState {
  final Task task;

  const CreatedTaskState(this.task);

  @override
  List<Object?> get props => [task];
}

final class UpdatedTaskState extends TaskState {
  final Task task;

  const UpdatedTaskState(this.task);

  @override
  List<Object?> get props => [task];
}

final class DeletedTaskState extends TaskState {
  final Task task;

  const DeletedTaskState(this.task);

  @override
  List<Object?> get props => [task];
}

final class ErrorState extends TaskState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
