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
          body: const Column(
            children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10.0, right: 10.0),
                    child: TaskList(),
                  )),
              Expanded(flex: 1, child: AddTask())
            ],
          )),
    );
  }
}
