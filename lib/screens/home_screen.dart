import 'package:flutter/material.dart';
import 'package:todo/widgets/task_add_widget.dart';
import 'package:todo/widgets/task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TODO List"),
        ),
        body: const Column(
          children: [
            Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TaskList(),
                )),
            Expanded(flex: 1, child: AddTask())
          ],
        ));
  }
}
