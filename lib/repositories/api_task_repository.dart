import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/task.dart';
import 'task_repository.dart';

class APITaskRepository extends ChangeNotifier implements TaskRepository {
  @override
  Future<List<Task>> getAllTasks() async {
    List<Task> tasks = [];
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/tasks'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(response.body);
        tasks = jsonResponse.map((task) => Task.fromJson(task)).toList();
      }
      return tasks;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    List<Task> tasks = [];
    try {
      final response = await http.get(
          Uri.parse('http://localhost:8080/tasks?completed=true'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(response.body);
        tasks = jsonResponse.map((task) => Task.fromJson(task)).toList();
      }

      return tasks;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<Task?> getTaskById(String id) async {
    Task? task;
    try {
      final response = await http.get(
          Uri.parse('http://localhost:8080/task/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(response.body);
        task = jsonResponse.map((task) => Task.fromJson(task)) as Task;
      }
      return task;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> addTask(Task task) async {
    try {
      await http.post(Uri.parse('http://localhost:8080/task'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            'title': task.title,
            'description': 'test',
            'created_at': task.createdAt.toUtc().toIso8601String(),
            'due_date': task.dueDate?.toUtc().toIso8601String(),
            'is_completed': task.isCompleted,
            'reward_in_sats': task.rewardInSatoshis
          }));
    } catch (error) {
      throw Exception(error);
    }
    notifyListeners();
  }

  @override
  Future<void> updateTask(Task task) async {
    String taskId = task.id;
    try {
      await http.put(Uri.parse('http://localhost:8080/task/$taskId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            'title': task.title,
            'description': task.description,
            'created_at': task.createdAt.toUtc().toIso8601String(),
            'is_completed': task.isCompleted,
            'reward_in_sats': task.rewardInSatoshis
          }));
    } catch (error) {
      throw Exception(error);
    }
    notifyListeners();
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await http.delete(Uri.parse('http://localhost:8080/task/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
    } catch (error) {
      throw Exception(error);
    }
    notifyListeners();
  }
}
