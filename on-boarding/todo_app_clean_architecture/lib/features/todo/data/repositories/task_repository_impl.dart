

import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app_clean_architecture/core/error/failures.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/repositories/task_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/task_local_datasource.dart';
import '../datasources/task_remote_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, Task>> completeTask(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Task>> createTask(Task task) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Task>> getTask(int id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Task>> removeTask(int id) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Task>>> viewAllTasks() {
    // TODO: implement viewAllTasks
    throw UnimplementedError();
  }

}