import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  final String itemText;
  const TaskItem(
    this.itemText, {
    super.key,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Checkbox(
              value: isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  isCompleted = value!;
                });
              }),
          SizedBox(
            width: 350,
            child: Text(widget.itemText,
                style: TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.clip,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
          )
        ],
      ),
    );
  }
}
