import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';

import '../repositories/api_task_repository.dart';

class AddTask extends StatefulWidget {
  const AddTask({
    super.key,
  });
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  late APITaskRepository taskRepository;
  late Future<List<Task>> taskListFuture;

  @override
  void initState() {
    super.initState();
    taskRepository = APITaskRepository();
    taskListFuture = taskRepository.getAllTasks();
  }

  @override
  void dispose() {
    titleTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(
                    Icons.circle,
                    color: Colors.transparent,
                    size: 50,
                  ),
                  IconButton(
                    iconSize: 35,
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: null,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create new task",
                style: const TextStyle(
                  fontSize: 25,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Title",
            style: const TextStyle(
              fontSize: 17,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key("task-input"),
            controller: titleTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Description",
            style: TextStyle(
              fontSize: 17,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: descriptionTextController,
            maxLines: 2,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Date",
                style: TextStyle(
                  fontSize: 17,
                  overflow: TextOverflow.clip,
                ),
              ),
              TextButton(
                onPressed: () => _selectDate(context),
                child: Text(selectedDateString,
                style: const TextStyle(
                  decoration: TextDecoration.underline
                ),),
              ),
            ],
          ),
        ),
        ElevatedButton(
            key: const Key("task-add-button"),
            onPressed: () async {
              if (titleTextController.text.isNotEmpty) {
                Task task = Task(
                  title: titleTextController.text,
                  description: descriptionTextController.text.isNotEmpty
                      ? descriptionTextController.text
                      : "",
                  createdAt: DateTime.now(),
                  dueDate: selectedDate,
                  isCompleted: false,
                  rewardInSatoshis: 0,
                );
                await Provider.of<APITaskRepository>(context, listen: false)
                    .addTask(task);
                titleTextController.clear();
                descriptionTextController.clear();
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pop(context);
              }
            },
            child: const Text("Done"))
      ],
    );
  }

  DateTime selectedDate = DateTime.now();
  String selectedDateString =
      DateFormat('dd/MM/yyyy', 'pt_BR').format(DateTime.now());
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        locale: const Locale("en"),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateString = DateFormat('dd/MM/yyyy', 'pt_BR').format(picked);
      });
    }
  }
}
