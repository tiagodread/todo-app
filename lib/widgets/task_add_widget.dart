import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({
    super.key,
  });
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final textController = TextEditingController();

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
              child: Consumer(
                  builder: (context, value, child) => ElevatedButton(
                      onPressed: () {
                        final widget = context.read<TaskModel>();
                        if (textController.text.isNotEmpty) {
                          widget.addTask(textController.text);
                          textController.clear();
                        }
                      },
                      child: const Text("ADD")))),
        ),
      ],
    );
  }
}
