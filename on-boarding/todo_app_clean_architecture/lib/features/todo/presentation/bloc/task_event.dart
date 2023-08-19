part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

final class CreateTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final String dueDate;

  const CreateTaskEvent({
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, dueDate];
}

final class GetSingleTaskEvent extends TaskEvent {
  final int id;

  const GetSingleTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class UpdateTaskEvent extends TaskEvent {
  final int id;
  final String title;
  final String description;
  final String dueDate;
  final bool isCompleted;

  const UpdateTaskEvent(
      {required this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      required this.isCompleted});

  @override
  List<Object?> get props => [id, title, description, dueDate, isCompleted];
}

final class DeleteTaskEvent extends TaskEvent {
  final int id;

  const DeleteTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class LoadAllTasksEvent extends TaskEvent {}
