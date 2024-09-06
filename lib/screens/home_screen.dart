import 'package:flutter/material.dart';
import 'package:todo/widgets/task_add_widget.dart';
import 'package:todo/widgets/task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Task List"),
        ),
        body: const TaskList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showBottomSheet(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

Future<void> _showBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return const AddTask();
    },
  );
}
