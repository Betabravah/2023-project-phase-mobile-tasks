import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../datasources/task_remote_datasource.dart';
import '../models/task_model.dart';

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
  Future<Either<Failure, Task>> createTask(Task task) async {
    final taskModel = await localDataSource.createTask(task.toModel());
    return Right(taskModel.toEntity());
  }

  @override
  Future<Either<Failure, Task>> getTask(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTask = await remoteDataSource.getTask(id);
        localDataSource.cacheTask();
        return Right(remoteTask);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
    try {
      final localTask = await localDataSource.getTask(id);
      return Right(localTask);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
    }
  }

  @override
  Future<Either<Failure, Task>> removeTask(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteTask(id);
        final taskModel = await localDataSource.removeTask(id);
        return Right(taskModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
    final taskModel = await localDataSource.removeTask(id);
    return Right(taskModel.toEntity());
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.updateTask(task.toModel()));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
    final taskModel = await localDataSource.updateTask(task.toModel());
    return Right(taskModel.toEntity());
    }
  }

  @override
  Future<Either<Failure, List<Task>>> viewAllTasks() async {
    List<TaskModel> taskModels;

    if (await networkInfo.isConnected) {
      try {
        taskModels = await remoteDataSource.getTasks();
          await localDataSource.cacheTask();
        
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
    taskModels = await localDataSource.viewAllTasks();
    }

    final tasks = taskModels.map((e) => e.toEntity()).toList();
    return Right(tasks);
  }
}
