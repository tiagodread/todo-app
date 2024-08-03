import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repositories/task_repository.dart';

import '../repositories/sqlite_task_repository.dart';

class AddTask extends StatefulWidget {
  const AddTask({
    super.key,
  });
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final textController = TextEditingController();
  late SQLiteTaskRepository taskRepository;
  late Future<List<Task>> taskListFuture;

  @override
  void initState() {
    super.initState();
    taskRepository = SQLiteTaskRepository();
    taskListFuture = taskRepository.getAllTasks();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                key: const Key("task-input"),
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a task',
                ),
              ),
            )),
        Expanded(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  key: const Key("task-add-button"),
                  onPressed: () async {
                    if (textController.text.isNotEmpty) {
                      Task task = Task(
                        title: textController.text,
                        description: '',
                        createdAt: DateTime.now(),
                        isCompleted: false,
                        rewardInSatoshis: 0,
                      );
                      await Provider.of<SQLiteTaskRepository>(context,
                              listen: false)
                          .addTask(task);
                      textController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  child: const Text("ADD"))),
        ),
      ],
    );
  }
}
