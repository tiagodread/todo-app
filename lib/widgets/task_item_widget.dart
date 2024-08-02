import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../repositories/sqlite_task_repository.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem(
    this.task, {
    super.key,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late SQLiteTaskRepository taskRepository;
  late Future<List<Task>> taskListFuture;

  @override
  void initState() {
    super.initState();
    taskRepository = SQLiteTaskRepository();
    taskListFuture = taskRepository.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, _, child) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Checkbox(
                      value: widget.task.isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          Task updatedTask = widget.task;
                          updatedTask.isCompleted = value!;
                          updatedTask.completedAt = DateTime.now();
                          Provider.of<SQLiteTaskRepository>(context,
                                  listen: false)
                              .updateTask(updatedTask);
                        });
                      }),
                  SizedBox(
                    width: 350,
                    child: Text(widget.task.title,
                        style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.clip,
                            decoration: widget.task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),
                  )
                ],
              ),
            ));
  }
}
