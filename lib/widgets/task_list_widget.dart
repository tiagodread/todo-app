import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/repositories/api_task_repository.dart';
import 'package:todo/widgets/task_item_widget.dart';

import '../models/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<APITaskRepository>(
        builder: (context, taskRepository, child) => FutureBuilder<List<Task>>(
            future: taskRepository.getAllTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('Start adding some work to do!'));
              } else {
                List<Task> tasks = snapshot.data!;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TaskItem(task, AppColors.getColor(index)),
                    );
                  },
                );
              }
            }));
  }
}
