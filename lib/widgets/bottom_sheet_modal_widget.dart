import 'package:flutter/material.dart';
import 'package:todo/widgets/task_add_widget.dart';

class BottomSheetModalWidget extends StatelessWidget {
  const BottomSheetModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 1000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
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
          AddTask(),
        ],
      ),
    );
  }
}
