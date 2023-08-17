import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';
import 'package:todo_app_clean_architecture/core/error/failures.dart';
import 'package:todo_app_clean_architecture/core/usecases/usecase.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/repositories/task_repository.dart';

import '../entities/task.dart';

class CreateTask implements UseCase<Task, CreateParams> {
  final TaskRepository repository;

  CreateTask(this.repository);
  
  @override
  Future<Either<Failure, Task>> call(CreateParams params) async {
    return await repository.createTask(params.task);
  }
}



class CreateParams extends Equatable{
  final Task task;
  const CreateParams({ required this.task});
  
  @override
  List<Object?> get props => [task];
}