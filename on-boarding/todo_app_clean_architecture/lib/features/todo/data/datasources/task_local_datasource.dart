import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_clean_architecture/core/error/exceptions.dart';

import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<TaskModel> createTask(TaskModel task);
  Future<TaskModel> getTask(int id);
  Future<TaskModel> updateTask(TaskModel task);
  Future<TaskModel> removeTask(int id);
  Future<List<TaskModel>> viewAllTasks();
  Future<void> cacheTask();
}

const CACHED_TASK = 'CACHED_TASK';
const CACHED_LAST_ID = 'CACHED_LAST_ID';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final SharedPreferences sharedPreferences;
  TaskLocalDataSourceImpl({required this.sharedPreferences});

  Future<int> _generateId() async {
    int id = sharedPreferences.getInt(CACHED_LAST_ID) ?? 1;
    await sharedPreferences.setInt(CACHED_LAST_ID, id + 1);

    return id;
  }

  @override
  Future<void> cacheTask() async {
    final tasks = await viewAllTasks();
    await sharedPreferences.setString(CACHED_TASK, jsonEncode(tasks));
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    final tasks = await viewAllTasks();

    final id = await _generateId();
    task = TaskModel(
        id: id,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate,
        isCompleted: task.isCompleted);

    tasks.add(task);

    await sharedPreferences.setString(CACHED_TASK, jsonEncode(tasks));

    return task;
  }

  @override
  Future<TaskModel> getTask(int id) async {
    final tasks = await viewAllTasks();

    for (final task in tasks) {
      if (task.id == id) {
        return task;
      }
    }

    throw CacheException(message: 'Task not found');
  }

  @override
  Future<TaskModel> removeTask(int id) async {
    final tasks = await viewAllTasks();

    final task = await getTask(id);

    tasks.removeWhere((element) => element.id == id);

    await sharedPreferences.setString(CACHED_TASK, jsonEncode(tasks));

    return task;
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    final tasks = await viewAllTasks();

    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].id == task.id) {
        tasks[i] = task;
        await sharedPreferences.setString(CACHED_TASK, jsonEncode(tasks));
        return task;
      }
    }
    throw CacheException(message: 'Task not found in cache');
  }

  @override
  Future<List<TaskModel>> viewAllTasks() {
    final jsonString = sharedPreferences.getString(CACHED_TASK) ?? "[]";
    try {
      final json = jsonDecode(jsonString) as List;
      final tasks = json.map((e) => TaskModel.fromJson(e)).toList();

      return Future.value(tasks);
    } on Exception catch (e) {
      throw CacheException(message: "Error $e");
    }
  }
}
