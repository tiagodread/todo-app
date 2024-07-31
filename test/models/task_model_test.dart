import 'package:flutter_test/flutter_test.dart';
import 'package:todo/models/task_model.dart';

void main(){
  group("Task Model", (){
    late TaskModel taskModel;

    setUp(() {
      taskModel = TaskModel();
    });

    test("Task list must be empty when initialized", () {
      expect(taskModel.taskList.length, 0);
    });

    test("Task list must contain item when incremented", () {
      taskModel.addTask("Study flutter!");
      expect(taskModel.taskList.length, 1);
    });
  });
}