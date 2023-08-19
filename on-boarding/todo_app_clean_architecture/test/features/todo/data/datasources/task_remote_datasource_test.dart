import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_clean_architecture/core/constants/constants.dart';
import 'package:todo_app_clean_architecture/core/error/exceptions.dart';
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_remote_datasource.dart';
import 'package:todo_app_clean_architecture/features/todo/data/models/task_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'task_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late TaskRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = TaskRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tTaskId = 1;

  final tTask = TaskModel(
      id: 1,
      title: "Task 1",
      description: "Task 1 description",
      isCompleted: true,
      dueDate: DateTime(2019, 1, 1));

  final tUpdatedTask = TaskModel(
      id: 1,
      title: "Updated Task 1",
      description: "Task 1 description",
      isCompleted: true,
      dueDate: DateTime(2019, 1, 1));

  group('create task', () {
    test(
        'should perform a POST request on a URL with number being the endpoint and with application/json header',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(fixture('task.json'), 201));
      // act
      await dataSource.createTask(tTask);
      // assert
      verify(mockHttpClient.post(
        Uri.parse(apiBaseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tTask.toJson()),
      ));
    });
    test('should thow a server exception when the response status is not 200',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(fixture('task.json'), 400));
      // act
      expect(() async => await dataSource.createTask(tTask),
          throwsA(isA<ServerException>()));
      // assert
      verify(mockHttpClient.post(
        Uri.parse(apiBaseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tTask.toJson()),
      ));
    });
    test('should return a taskmodel when the response status is 200', () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(fixture('task.json'), 201));
      // act
      final result = await dataSource.createTask(tTask);

      // assert
      expect(result, equals(tTask));
    });
  });

  group('get task', () {
    test(
        'should perform a GET request on a URL with tTaskId being the endpoint',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
      // act
      await dataSource.getTask(tTaskId);
      // assert
      verify(mockHttpClient.get(
        Uri.parse('$apiBaseUrl/$tTaskId'),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });
    test('should thow a server exception when the response status is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('task.json'), 404));
      // act
      expect(() async => await dataSource.getTask(tTaskId),
          throwsA(isA<ServerException>()));
      // assert
      verify(mockHttpClient.get(
        Uri.parse('$apiBaseUrl/$tTaskId'),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return a taskmodel when the response status is 200', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
      // act
      final result = await dataSource.getTask(tTaskId);
      // assert
      expect(result, equals(tTask));
    });
  });

  group('get tasks', () {
    test('should perform a GET request on base URL', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_store.json'), 200));
      // act
      await dataSource.getTasks();
      // assert
      verify(mockHttpClient.get(
        Uri.parse(apiBaseUrl),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });
    test('should thow a server exception when the response status is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_store.json'), 404));
      // act
      expect(() async => await dataSource.getTasks(),
          throwsA(isA<ServerException>()));
      // assert
    });
    test('should return a list of taskmodel when the response status is 200',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task_store.json'), 200));
      // act
      final result = await dataSource.getTasks();
      // assert
      expect(result, isA<List<TaskModel>>());
    });
  });

  group('delete task', () {
    test(
        'should perform a DELETE request on a URL with tTaskId being the endpoint',
        () async {
      // arrange
      when(mockHttpClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
      // act
      await dataSource.deleteTask(tTaskId);
      // assert
      verify(mockHttpClient.delete(
        Uri.parse('$apiBaseUrl/$tTaskId'),
        headers: {'Content-Type': 'application/json'},
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should thow a server exception when the response status is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task.json'), 404));
      // act
      expect(() async => await dataSource.deleteTask(tTaskId),
          throwsA(isA<ServerException>()));
      // assert
    });
    test('should return a taskmodel when the response status is 200',
        () async {
      // arrange
      when(mockHttpClient.delete(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task.json'), 200));
      // act
      final result = await dataSource.deleteTask(tTaskId);
      // assert
      expect(result, isA<TaskModel>());
    });
  });

  group('update task', () {
    test(
        'should perform a PUT request on a URL with tTaskId being the endpoint',
        () async {
      when(mockHttpClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
      // act
      await dataSource.updateTask(tUpdatedTask);
      verify(mockHttpClient.put(
        Uri.parse('$apiBaseUrl/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tUpdatedTask.toJson()),
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });
    test('should thow a server exception when the response status is not 200',
        () async {
      // arrange
      when(mockHttpClient.put(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task.json'), 404));
      // act
      expect(() async => await dataSource.updateTask(tTask),
          throwsA(isA<ServerException>()));
      // assert
    });
    test(
        'should return a taskmodel when the status is 200',
        () async {
      when(mockHttpClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
      // act
      final result = await dataSource.updateTask(tUpdatedTask);
      expect(result, equals(tTask));
    });
  });
}
