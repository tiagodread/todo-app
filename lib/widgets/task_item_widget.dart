import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../repositories/api_task_repository.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final Color taskItemColor;
  const TaskItem(
    this.task,
    this.taskItemColor, {
    super.key,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late APITaskRepository taskRepository;
  late Future<List<Task>> taskListFuture;

  @override
  void initState() {
    super.initState();
    taskRepository = APITaskRepository();
    taskListFuture = taskRepository.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, _, child) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.taskItemColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, top: 10),
                                child: Text(
                                  widget.task.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ),
                              Text(
                                widget.task.description,
                                style: const TextStyle(
                                  fontSize: 15,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  DateFormat('dd/MM/yyyy', 'pt_BR')
                                      .format(widget.task.createdAt),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.taskItemColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )),
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                IconButton(
                                  onPressed: () {
                                    _showConfirmationDialog(context,
                                        "Would you like to mark this task as completed?",
                                        () {
                                      Task updatedTask = widget.task;
                                      updatedTask.isCompleted = true;
                                      updatedTask.completedAt = DateTime.now();
                                      Provider.of<APITaskRepository>(context,
                                              listen: false)
                                          .updateTask(updatedTask);
                                    });
                                  },
                                  iconSize: 35,
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                IconButton(
                                  onPressed: () {
                                    _showConfirmationDialog(context,
                                        "Would you like to delete this task?",
                                        () {
                                      Provider.of<APITaskRepository>(context,
                                              listen: false)
                                          .deleteTask(widget.task.id);
                                    });
                                  },
                                  iconSize: 35,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ));
  }
}

Future<void> _showConfirmationDialog(
    context, String message, Function? function) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title: const Text("Confirm?"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              function!();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
