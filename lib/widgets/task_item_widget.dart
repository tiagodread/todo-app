import 'package:flutter/material.dart';

import '../models/task.dart';

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Checkbox(
              value: widget.task.isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  widget.task.isCompleted = value!;
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
    );
  }
}
