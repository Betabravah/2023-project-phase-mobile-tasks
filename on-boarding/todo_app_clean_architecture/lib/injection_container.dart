import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_convertor.dart';
import 'features/todo/data/datasources/task_local_datasource.dart';
import 'features/todo/data/datasources/task_remote_datasource.dart';
import 'features/todo/data/repositories/task_repository_impl.dart';
import 'features/todo/domain/repositories/task_repository.dart';
import 'features/todo/domain/usecases/usecases.dart' as usecases;
import 'features/todo/presentation/bloc/task_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features
  //
  // Bloc
  serviceLocator.registerFactory(
    () => TaskBloc(
      createTask: serviceLocator(),
      getTask: serviceLocator(),
      getAllTasks: serviceLocator(),
      updateTask: serviceLocator(),
      deleteTask: serviceLocator(),
      inputConvertor: serviceLocator(),
    ),
  );
  //
  // usecases
  serviceLocator
      .registerLazySingleton(() => usecases.CreateTask(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => usecases.GetTask(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => usecases.ViewAllTasks(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => usecases.EditTask(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => usecases.RemoveTask(serviceLocator()));
  //
  // repository
  serviceLocator.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator()));
  //
  //  datasources
  serviceLocator.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl(sharedPreferences: serviceLocator()));

  //! Core
  serviceLocator.registerLazySingleton(() => InputConverter());
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(serviceLocator()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
