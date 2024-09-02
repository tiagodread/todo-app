import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/repositories/api_task_repository.dart';
import 'package:todo/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => APITaskRepository(),
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO List",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
