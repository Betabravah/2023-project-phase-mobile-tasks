import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';
import 'package:todo_app_clean_architecture/core/error/failures.dart';
import 'package:todo_app_clean_architecture/core/usecases/usecase.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/repositories/task_repository.dart';

import '../entities/task.dart';

class RemoveTask implements UseCase<Task, DeleteParams> {
  final TaskRepository repository;

  RemoveTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(DeleteParams params) async {
    return await repository.removeTask(params.id);
  }
}

class DeleteParams extends Equatable {
  final int id;
  const DeleteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
