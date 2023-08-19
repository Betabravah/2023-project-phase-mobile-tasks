import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app_clean_architecture/core/error/exceptions.dart';

import '../../../../core/constants/constants.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<TaskModel> createTask(TaskModel task);
  Future<TaskModel> getTask(int id);
  Future<TaskModel> updateTask(TaskModel task);
  Future<TaskModel> deleteTask(int id);
  Future<List<TaskModel>> getTasks();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final http.Client client;

  TaskRemoteDataSourceImpl({required this.client});

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    try {
      final response = await client.post(Uri.parse(apiBaseUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(task.toJson()));

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final taskModel = TaskModel.fromJson(json);
        return taskModel;
      } else {
        throw ServerException(message: "Error creating task");
      }
    } catch (e) {
      throw ServerException(message: "Network error");
    }
  }

  @override
  Future<TaskModel> getTask(int id) async {
    try {
      final response = await client.get(Uri.parse('$apiBaseUrl/$id'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body);
          final taskModel = TaskModel.fromJson(json);
          return taskModel;
        } catch (e) {
          throw ServerException(message: "Error parsing task");
        }
      } else {
        throw ServerException(message: 'Error when getting task');
      }
    } catch (e) {
      throw ServerException(message: 'Network erro');
    }
  }

  @override
  Future<TaskModel> deleteTask(int id) async {
    try {
      final response = await client.delete(Uri.parse('$apiBaseUrl/$id'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body);
          final taskModel = TaskModel.fromJson(json);
          return taskModel;
        } catch (e) {
          throw ServerException(message: "Error parsing task");
        }
      } else {
        throw ServerException(message: "Error deleting task");
      }
    } catch (e) {
      throw ServerException(message: "Network error");
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      final response = await client.put(Uri.parse('$apiBaseUrl/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(task.toJson()));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final taskModel = TaskModel.fromJson(json);
        return taskModel;
      } else {
        throw ServerException(message: "Error updating task");
      }
    } catch (e) {
      throw ServerException(message: "Network error");
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await client.get(Uri.parse(apiBaseUrl),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final jsonList = jsonDecode(response.body) as List<dynamic>;
        final taskModels =
            jsonList.map((json) => TaskModel.fromJson(json)).toList();
        return taskModels;
      } else {
        throw ServerException(message: 'Error getting tasks');
      }
    } catch (e) {
      throw ServerException(message: "Error getting tasks");
    }
  }
}
