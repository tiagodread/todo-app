import 'package:flutter/foundation.dart';

class TaskModel extends ChangeNotifier{
  final List _taskList = <String>[];
  List get taskList => _taskList;

  void addTask(String task){
    _taskList.add(task);
    notifyListeners();
  }
}