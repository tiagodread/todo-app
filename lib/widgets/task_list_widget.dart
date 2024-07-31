import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/task_item_widget.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(builder: (context, value, child) {
      
      final widget = context.read<TaskModel>();
      final List<TaskItem> taskItems = [];
      
      widget.taskList.forEach((task) {
        taskItems.add(TaskItem(task.toString()));
      });

      return ListView(
        children: taskItems,
      );
    });
  }
}
