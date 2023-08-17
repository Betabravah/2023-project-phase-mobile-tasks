import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/task_repository.dart';

import '../entities/task.dart';

class GetTask implements UseCase<Task, GetParams> {
  final TaskRepository repository;

  GetTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(GetParams params) async {
    return await repository.getTask(params.id);
  }
}

class GetParams extends Equatable {
  final int id;
  const GetParams({required this.id});

  @override
  List<Object?> get props => [id];
}
