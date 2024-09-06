import 'package:flutter/material.dart';
import 'package:path/path.dart';
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
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.circle,
                        color: Colors.transparent,
                        size: 50,
                      ),
                      IconButton(
                        iconSize: 35,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const AddTask(),
          ],
        ),
      );
    },
  );
}
