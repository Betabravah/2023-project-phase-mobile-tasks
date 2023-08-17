import 'dart:async';

import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';


class EditTask implements UseCase<Task, EditParams> {
  final TaskRepository repository;

  EditTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(EditParams params) async {
    return await repository.updateTask(params.task);
  }
}

class EditParams extends Equatable {
  final Task task;
  const EditParams({required this.task});

  @override
  List<Object?> get props => [task];
}
