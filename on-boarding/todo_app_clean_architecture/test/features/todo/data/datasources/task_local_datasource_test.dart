import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_clean_architecture/core/error/exceptions.dart';
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_local_datasource.dart';
import 'package:todo_app_clean_architecture/features/todo/data/models/task_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'task_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late TaskLocalDataSourceImpl taskLocalDataSourceIml;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    taskLocalDataSourceIml =
        TaskLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  const tTaskid = 1;

  final tTask = TaskModel(
      id: 1,
      title: "Task 1",
      description: "Task 1 description",
      isCompleted: true,
      dueDate: DateTime(2019, 1, 1));

  final tTaskUpdated = TaskModel(
      id: 1,
      title: "Task 2",
      description: "Task 2 description",
      isCompleted: true,
      dueDate: DateTime(2019, 1, 1));

  final tTaskStore = [tTask];
  group('get task', () {
    test("should return empty list when there no task in the cache", () async {
      when(mockSharedPreferences.getString(CACHED_TASK))
          .thenAnswer((_) => fixture('empty_task_store.json'));

      final result = await taskLocalDataSourceIml.viewAllTasks();
      expect(result, isEmpty);

      verify(mockSharedPreferences.getString(CACHED_TASK));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should return task list from SharedPreferencee', () async {
      when(mockSharedPreferences.getString(CACHED_TASK))
          .thenAnswer((_) => fixture('task_store.json'));

      final result = await taskLocalDataSourceIml.viewAllTasks();
      expect(result, tTaskStore);

      verify(mockSharedPreferences.getString(CACHED_TASK));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should get task by id', () async {
      when(mockSharedPreferences.getString(CACHED_TASK))
          .thenAnswer((_) => fixture('task_store.json'));

      final result = await taskLocalDataSourceIml.getTask(tTaskid);
      expect(result, tTask);

      verify(mockSharedPreferences.getString(CACHED_TASK));
      verifyNoMoreInteractions((mockSharedPreferences));
    });

    test('should throw CacheException when task is not found', () async {
      when(mockSharedPreferences.getString(CACHED_TASK))
          .thenAnswer((_) => fixture('task_store.json'));

      expect(() async => await taskLocalDataSourceIml.getTask(2),
          throwsA(isA<CacheException>()));

      verify(mockSharedPreferences.getString(CACHED_TASK));
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });

  group('create task', () {
    test('should generate id create task and store it on sharedpreference',
        () async {
      when(mockSharedPreferences.getString(CACHED_TASK))
          .thenAnswer((_) => fixture('empty_task_store.json'));
      when(mockSharedPreferences.getInt(CACHED_LAST_ID)).thenAnswer((_) => 1);
      when(mockSharedPreferences.setInt(CACHED_LAST_ID, 2))
          .thenAnswer((_) => Future.value(true));
      when(mockSharedPreferences.setString(
              CACHED_TASK, jsonEncode([tTask.toJson()])))
          .thenAnswer((_) => Future.value(true));

      await taskLocalDataSourceIml.createTask(tTask);

      verify(mockSharedPreferences.getString(CACHED_TASK));
      verify(mockSharedPreferences.getInt(CACHED_LAST_ID));
      verify(mockSharedPreferences.setInt(CACHED_LAST_ID, 2));
      verify(mockSharedPreferences.setString(
          CACHED_TASK, jsonEncode([tTask.toJson()])));
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });

  group('update task', () {
    test('should call getstring and setString on sharedpreference', () async {
      when(mockSharedPreferences.getString(CACHED_TASK))
          .thenAnswer((_) => fixture('task_store.json'));
      when(mockSharedPreferences.setString(
              CACHED_TASK, jsonEncode([tTaskUpdated.toJson()])))
          .thenAnswer((_) async => true);

      await taskLocalDataSourceIml.updateTask(tTaskUpdated);

      verify(mockSharedPreferences.getString(CACHED_TASK));
      verify(mockSharedPreferences.setString(
          CACHED_TASK, jsonEncode([tTaskUpdated.toJson()])));
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
  group('remove task', () {
    test('should call getstring and setString on sharedpreference', () async {
      when(mockSharedPreferences.getString(CACHED_TASK))
          .thenAnswer((_) => fixture('task_store.json'));
      when(mockSharedPreferences.setString(
              CACHED_TASK, jsonEncode([])))
          .thenAnswer((_) => Future.value(true));


      await taskLocalDataSourceIml.removeTask(tTask.id);

      verify(mockSharedPreferences.getString(CACHED_TASK));
      verify(mockSharedPreferences.setString(CACHED_TASK, jsonEncode([])));
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}
